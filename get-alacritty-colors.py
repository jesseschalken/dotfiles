#!/usr/bin/env python3
# ruff: noqa: E741

from __future__ import annotations

from math import cbrt, sqrt, degrees, atan2, sin, cos, radians
from typing import NamedTuple

float3d = tuple[float, float, float]


def lab_to_lch(l: float, a: float, b: float) -> float3d:
    return l, sqrt(a * a + b * b), degrees(atan2(b, a))


def oklab_to_linear_srgb(l: float, a: float, b: float) -> float3d:
    l_ = l + 0.3963377774 * a + 0.2158037573 * b
    m_ = l - 0.1055613458 * a - 0.0638541728 * b
    s_ = l - 0.0894841775 * a - 1.2914855480 * b

    l = l_**3
    m = m_**3
    s = s_**3

    return (
        +4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
        -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
        -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s,
    )


def rgb_to_hex(r: float, g: float, b: float) -> str:
    return "#{0:02x}{1:02x}{2:02x}".format(
        round(r * 255),
        round(g * 255),
        round(b * 255),
    )


def rgb_clamp(r: float, g: float, b: float) -> float3d:
    r = min(max(r, 0.0), 1.0)
    g = min(max(g, 0.0), 1.0)
    b = min(max(b, 0.0), 1.0)
    return r, g, b


def srgb_to_oklch(r: float, g: float, b: float) -> float3d:
    r = srgb_to_linear(r)
    g = srgb_to_linear(g)
    b = srgb_to_linear(b)
    return lab_to_lch(*srgb_linear_to_oklab(r, g, b))


def srgb_linear_to_oklab(r: float, g: float, b: float) -> float3d:
    l = 0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b
    m = 0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b
    s = 0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b

    l_ = cbrt(l)
    m_ = cbrt(m)
    s_ = cbrt(s)

    return (
        0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_,
        1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_,
        0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_,
    )


def lch_to_lab(l: float, c: float, h: float) -> float3d:
    return l, c * cos(radians(h)), c * sin(radians(h))


def oklch_to_srgb(l: float, c: float, h: float) -> float3d:
    r, g, b = oklab_to_linear_srgb(*lch_to_lab(l, c, h))
    r = linear_to_srgb(r)
    g = linear_to_srgb(g)
    b = linear_to_srgb(b)
    return rgb_clamp(r, g, b)


def oklch_to_srgb_hex(l: float, c: float, h: float) -> str:
    r, g, b = oklch_to_srgb(l, c, h)
    l2, _, h2 = srgb_to_oklch(r, g, b)

    index = 0
    while (
        abs(l - l2) > MAX_LIGHTNESS_DIFF or abs(hue_diff(h, h2)) > MAX_HUE_DIFF
    ) and index < 1000:
        r, g, b = oklch_to_srgb(l, max(0, c - index / 1000), h)
        l2, _, h2 = srgb_to_oklch(r, g, b)
        index += 1

    return rgb_to_hex(r, g, b)


def hue_diff(h1: float, h2: float) -> float:
    return (h1 - h2 + 180) % 360 - 180


def linear_to_srgb(x: float) -> float:
    return 12.92 * x if x <= 0.0031308 else 1.055 * (x ** (1.0 / 2.4)) - 0.055


def srgb_to_linear(x: float) -> float:
    return x / 12.92 if x <= 0.04045 else ((x + 0.055) / 1.055) ** 2.4


class ColorConfig(NamedTuple):
    dim: list[float3d]
    normal: list[float3d]
    bright: list[float3d]

    def print_alacritty(self):
        names = ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"]

        for shade, colors in zip(["dim", "normal", "bright"], self):
            print(f"[colors.{shade}]")
            for lch, name in zip(colors, names):
                print(f"{name} = '{oklch_to_srgb_hex(*lch)}'")
            print()

        print("[colors.primary]")
        print(f"background = '{oklch_to_srgb_hex(*BLACK)}'")
        print(f"foreground = '{oklch_to_srgb_hex(*self.normal[7])}'")
        print(f"dim_foreground = '{oklch_to_srgb_hex(*self.dim[7])}'")
        print(f"bright_foreground = '{oklch_to_srgb_hex(*self.bright[7])}'")
        print()

    def print_wezterm(self):
        print(f"foreground = '{oklch_to_srgb_hex(*self.normal[7])}',")
        print(f"background = '{oklch_to_srgb_hex(*BLACK)}',")
        print("ansi = {")
        for lch in self.normal:
            print(f"  '{oklch_to_srgb_hex(*lch)}',")
        print("},")
        print("brights = {")
        for lch in self.bright:
            print(f"  '{oklch_to_srgb_hex(*lch)}',")
        print("},")


MAX_LIGHTNESS_DIFF = 0.2
MAX_HUE_DIFF = 5

PRIMARIES = [
    (1, 0, 0),
    (0, 1, 0),
    (0, 0, 1),
]

BLACK = 0, 0, 0


def main():
    step = 0.25

    l = 1 - step
    c = 0.4
    h = sum(srgb_to_oklch(*x)[2] % 360 for x in PRIMARIES) / 3 - 120

    colors: list[float3d] = [
        (l - step * 2, 0, 0),
        (l, c, h),
        (l, c, h + 120),
        (l, c, h + 60),
        (l, c, h + 240),
        (l, c, h + 300),
        (l, c, h + 180),
        (l, 0, 0),
    ]

    config = ColorConfig(
        [(l - step, c, h) for l, c, h in colors],
        [(l, c, h - 15) for l, c, h in colors],
        [
            (l + step, c, h) if i in [0, 7] else (l, c, h + 15)
            for i, (l, c, h) in enumerate(colors)
        ],
    )

    config.print_alacritty()


if __name__ == "__main__":
    main()
