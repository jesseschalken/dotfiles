#!/usr/bin/env python3
# ruff: noqa: E741

from __future__ import annotations

from math import cbrt, sqrt, degrees, atan2, sin, cos, radians
from typing import NamedTuple


class Lab(NamedTuple):
    l: float
    a: float
    b: float

    def to_lch(self) -> LCh:
        l, a, b = self
        return LCh(l, sqrt(a * a + b * b), degrees(atan2(b, a)))

    def to_linear_srgb(self) -> RGB:
        l, a, b = self

        l_ = l + 0.3963377774 * a + 0.2158037573 * b
        m_ = l - 0.1055613458 * a - 0.0638541728 * b
        s_ = l - 0.0894841775 * a - 1.2914855480 * b

        l = l_**3
        m = m_**3
        s = s_**3

        return RGB(
            +4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
            -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
            -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s,
        )


class RGB(NamedTuple):
    r: float
    g: float
    b: float

    def to_hex(self) -> str:
        return "#{0:02x}{1:02x}{2:02x}".format(
            round(self.r * 255),
            round(self.g * 255),
            round(self.b * 255),
        )

    def clamp(self) -> RGB:
        return RGB(
            min(max(self.r, 0.0), 1.0),
            min(max(self.g, 0.0), 1.0),
            min(max(self.b, 0.0), 1.0),
        )

    def to_oklch(self) -> LCh:
        r, g, b = self
        r = srgb_to_linear(r)
        g = srgb_to_linear(g)
        b = srgb_to_linear(b)
        return RGB(r, g, b).linear_to_oklab().to_lch()

    def linear_to_oklab(self) -> Lab:
        r, g, b = self

        l = 0.4122214708 * r + 0.5363325363 * g + 0.0514459929 * b
        m = 0.2119034982 * r + 0.6806995451 * g + 0.1073969566 * b
        s = 0.0883024619 * r + 0.2817188376 * g + 0.6299787005 * b

        l_ = cbrt(l)
        m_ = cbrt(m)
        s_ = cbrt(s)

        return Lab(
            0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_,
            1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_,
            0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_,
        )


class LCh(NamedTuple):
    l: float
    c: float
    h: float

    def to_oklab(self) -> Lab:
        l, c, h = self
        h_rad = radians(h)
        return Lab(l, c * cos(h_rad), c * sin(h_rad))

    def to_srgb(self) -> RGB:
        r, g, b = self.to_oklab().to_linear_srgb()
        r = linear_to_srgb(r)
        g = linear_to_srgb(g)
        b = linear_to_srgb(b)
        return RGB(r, g, b).clamp()

    def to_srgb_hex(self) -> str:
        rgb = self.to_srgb()
        diff = rgb.to_oklch().diff(self)

        index = 0
        while (diff.l > MAX_LIGHTNESS_DIFF or diff.h > MAX_HUE_DIFF) and index < 1000:
            l, c, h = self
            rgb = LCh(l, max(0, c - index / 1000), h).to_srgb()
            diff = rgb.to_oklch().diff(self)
            index += 1

        return rgb.to_hex()

    def diff(self, other: LCh) -> LCh:
        l = abs(self.l - other.l)
        c = abs(self.c - other.c)
        h = abs((self.h % 360) - (other.h % 360))
        return LCh(l, c, min(h, 360 - h))


def linear_to_srgb(x: float) -> float:
    return 12.92 * x if x <= 0.0031308 else 1.055 * (x ** (1.0 / 2.4)) - 0.055


def srgb_to_linear(x: float) -> float:
    return x / 12.92 if x <= 0.04045 else ((x + 0.055) / 1.055) ** 2.4


class ColorConfig(NamedTuple):
    dim: list[LCh]
    normal: list[LCh]
    bright: list[LCh]

    def print_alacritty(self):
        names = ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"]

        for shade, colors in zip(["dim", "normal", "bright"], self):
            print(f"[colors.{shade}]")
            for lch, name in zip(colors, names):
                print(f"{name} = '{lch.to_srgb_hex()}'")
            print()

        print("[colors.primary]")
        print(f"background = '{BLACK.to_srgb_hex()}'")
        print(f"foreground = '{self.normal[7].to_srgb_hex()}'")
        print(f"dim_foreground = '{self.dim[7].to_srgb_hex()}'")
        print(f"bright_foreground = '{self.bright[7].to_srgb_hex()}'")
        print()

    def print_wezterm(self):
        print(f"foreground = '{self.normal[7].to_srgb_hex()}',")
        print(f"background = '{BLACK.to_srgb_hex()}',")
        print("ansi = {")
        for lch in self.normal:
            print(f"  '{lch.to_srgb_hex()}',")
        print("},")
        print("brights = {")
        for lch in self.bright:
            print(f"  '{lch.to_srgb_hex()}',")
        print("},")


MAX_LIGHTNESS_DIFF = 0.2
MAX_HUE_DIFF = 5

PRIMARIES = [
    (1, 0, 0),
    (0, 1, 0),
    (0, 0, 1),
]

BLACK = LCh(0, 0, 0)


def main():
    step = 0.25

    l = 1 - step
    c = 0.4
    h = sum(RGB(*x).to_oklch().h % 360 for x in PRIMARIES) / 3 - 120

    colors = [
        LCh(l - step * 2, 0, 0),
        LCh(l, c, h),
        LCh(l, c, h + 120),
        LCh(l, c, h + 60),
        LCh(l, c, h + 240),
        LCh(l, c, h + 300),
        LCh(l, c, h + 180),
        LCh(l, 0, 0),
    ]

    config = ColorConfig(
        [LCh(l - step, c, h) for l, c, h in colors],
        [LCh(l, c, h - 15) for l, c, h in colors],
        [
            LCh(l + step, c, h) if i in [0, 7] else LCh(l, c, h + 15)
            for i, (l, c, h) in enumerate(colors)
        ],
    )

    config.print_alacritty()


if __name__ == "__main__":
    main()
