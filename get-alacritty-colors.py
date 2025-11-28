#!/usr/bin/env python3
# ruff: noqa: E741


from __future__ import annotations

from dataclasses import dataclass
from typing import Callable
import math
import sys


@dataclass
class okLab:
    l: float
    a: float
    b: float

    def to_lch(self) -> okLCh:
        c = math.sqrt(self.a * self.a + self.b * self.b)
        h = math.degrees(math.atan2(self.b, self.a)) % 360
        return okLCh(self.l, c, h)

    def to_linear_srgb(self) -> sRGB:
        l_ = self.l + 0.3963377774 * self.a + 0.2158037573 * self.b
        m_ = self.l - 0.1055613458 * self.a - 0.0638541728 * self.b
        s_ = self.l - 0.0894841775 * self.a - 1.2914855480 * self.b

        l = l_**3
        m = m_**3
        s = s_**3

        return sRGB(
            +4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
            -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
            -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s,
        )


@dataclass
class sRGB:
    r: float
    g: float
    b: float

    def to_hex(self) -> str:
        return "#{0:02x}{1:02x}{2:02x}".format(
            int(self.r * 255), int(self.g * 255), int(self.b * 255)
        )

    def map(self, func: Callable[[float], float]) -> sRGB:
        return sRGB(
            r=func(self.r),
            g=func(self.g),
            b=func(self.b),
        )

    def clamp(self) -> sRGB:
        return self.map(lambda x: min(max(x, 0.0), 1.0))

    def to_oklch(self) -> okLCh:
        return self.map(srgb_to_linear).linear_to_oklab().to_lch()

    def linear_to_oklab(self) -> okLab:
        l = 0.4122214708 * self.r + 0.5363325363 * self.g + 0.0514459929 * self.b
        m = 0.2119034982 * self.r + 0.6806995451 * self.g + 0.1073969566 * self.b
        s = 0.0883024619 * self.r + 0.2817188376 * self.g + 0.6299787005 * self.b

        l_ = math.cbrt(l)
        m_ = math.cbrt(m)
        s_ = math.cbrt(s)

        return okLab(
            0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_,
            1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_,
            0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_,
        )


@dataclass
class okLCh:
    l: float
    c: float
    h: float

    def to_oklab(self) -> okLab:
        h_radians = math.radians(self.h)
        a = self.c * math.cos(h_radians)
        b = self.c * math.sin(h_radians)
        return okLab(self.l, a, b)

    def to_srgb(self) -> sRGB:
        return self.to_oklab().to_linear_srgb().map(linear_to_srgb).clamp()

    def to_srgb_hex(self) -> str:
        rgb = self.to_srgb()
        lch = rgb.to_oklch()

        if self.c == 0.0:
            lch = okLCh(lch.l, 0.0, self.h)

        diff = okLCh(
            abs(self.l - lch.l),
            abs(self.c - lch.c),
            abs(self.h - lch.h),
        )

        if diff.l > MAX_DIFF.l or diff.c > MAX_DIFF.c or diff.h > MAX_DIFF.h:
            print(
                f"Color {self} is too far out of sRGB gamut (achieved {lch}, diff {diff}, max diff {MAX_DIFF})",
                file=sys.stderr,
            )

        return rgb.to_hex()

    def __add__(self, other: okLCh) -> okLCh:
        return okLCh(
            self.l + other.l,
            self.c + other.c,
            (self.h + other.h) % 360,
        )


def linear_to_srgb(x: float) -> float:
    return 12.92 * x if x <= 0.0031308 else 1.055 * (x ** (1.0 / 2.4)) - 0.055


def srgb_to_linear(x: float) -> float:
    return x / 12.92 if x <= 0.04045 else ((x + 0.055) / 1.055) ** 2.4


MAX_DIFF = okLCh(0.20, 0.30, 20)
COLOR_BASE = okLCh(0.82, 0.36, 30)

HUES = {
    "red": 0,
    "yellow": 60,
    "green": 120,
    "cyan": 180,
    "blue": 240,
    "magenta": 300,
}

NEUTRALS = {
    "black": (0.2, 0.4),
    "white": (0.8, 1.0),
}

PRIMARIES = {
    "background": 0.0,
    "dim_foreground": 0.6,
    "foreground": 0.8,
    "bright_foreground": 1.0,
}


def main():
    print("[colors.normal]")

    for name, h in HUES.items():
        print(f"{name} = '{(COLOR_BASE + okLCh(0, 0, h - 15)).to_srgb_hex()}'")

    for name, (l, _) in NEUTRALS.items():
        print(f"{name} = '{okLCh(l, 0, 0).to_srgb_hex()}'")

    print("[colors.bright]")

    for name, h in HUES.items():
        print(f"{name} = '{(COLOR_BASE + okLCh(0, 0, h + 15)).to_srgb_hex()}'")

    for name, (_, l) in NEUTRALS.items():
        print(f"{name} = '{okLCh(l, 0, 0).to_srgb_hex()}'")

    print("[colors.primary]")

    for name, l in PRIMARIES.items():
        print(f"{name} = '{okLCh(l, 0, 0).to_srgb_hex()}'")


if __name__ == "__main__":
    main()
