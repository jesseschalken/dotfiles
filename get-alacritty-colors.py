#!/usr/bin/env python3
# ruff: noqa: E741


from __future__ import annotations

from dataclasses import dataclass
from typing import Callable
import math


@dataclass
class Lab:
    l: float
    a: float
    b: float

    def to_lch(self) -> LCh:
        c = math.sqrt(self.a * self.a + self.b * self.b)
        h = math.degrees(math.atan2(self.b, self.a)) % 360
        return LCh(self.l, c, h)

    def to_linear_srgb(self) -> RGB:
        l_ = self.l + 0.3963377774 * self.a + 0.2158037573 * self.b
        m_ = self.l - 0.1055613458 * self.a - 0.0638541728 * self.b
        s_ = self.l - 0.0894841775 * self.a - 1.2914855480 * self.b

        l = l_**3
        m = m_**3
        s = s_**3

        return RGB(
            +4.0767416621 * l - 3.3077115913 * m + 0.2309699292 * s,
            -1.2684380046 * l + 2.6097574011 * m - 0.3413193965 * s,
            -0.0041960863 * l - 0.7034186147 * m + 1.7076147010 * s,
        )


@dataclass
class RGB:
    r: float
    g: float
    b: float

    def to_hex(self) -> str:
        return "#{0:02x}{1:02x}{2:02x}".format(
            round(self.r * 255), round(self.g * 255), round(self.b * 255)
        )

    def map(self, func: Callable[[float], float]) -> RGB:
        return RGB(
            r=func(self.r),
            g=func(self.g),
            b=func(self.b),
        )

    def clamp(self) -> RGB:
        return self.map(lambda x: min(max(x, 0.0), 1.0))

    def to_oklch(self) -> LCh:
        return self.map(srgb_to_linear).linear_to_oklab().to_lch()

    def linear_to_oklab(self) -> Lab:
        l = 0.4122214708 * self.r + 0.5363325363 * self.g + 0.0514459929 * self.b
        m = 0.2119034982 * self.r + 0.6806995451 * self.g + 0.1073969566 * self.b
        s = 0.0883024619 * self.r + 0.2817188376 * self.g + 0.6299787005 * self.b

        l_ = math.cbrt(l)
        m_ = math.cbrt(m)
        s_ = math.cbrt(s)

        return Lab(
            0.2104542553 * l_ + 0.7936177850 * m_ - 0.0040720468 * s_,
            1.9779984951 * l_ - 2.4285922050 * m_ + 0.4505937099 * s_,
            0.0259040371 * l_ + 0.7827717662 * m_ - 0.8086757660 * s_,
        )


@dataclass
class LCh:
    l: float
    c: float
    h: float

    def to_oklab(self) -> Lab:
        h_radians = math.radians(self.h)
        a = self.c * math.cos(h_radians)
        b = self.c * math.sin(h_radians)
        return Lab(self.l, a, b)

    def to_srgb(self) -> RGB:
        return self.to_oklab().to_linear_srgb().map(linear_to_srgb).clamp()

    def to_srgb_hex(self) -> str:
        rgb = self.to_srgb()
        diff = abs(self - rgb.to_oklch())

        index = 0
        while (
            diff.l > MAX_DIFF.l or diff.c > MAX_DIFF.c or diff.h > MAX_DIFF.h
        ) and index < 1000:
            rgb = LCh(self.l, max(0, self.c - index * 0.001), self.h).to_srgb()
            diff = abs(self - rgb.to_oklch())
            index += 1

        return rgb.to_hex()

    def __add__(self, other: LCh) -> LCh:
        return LCh(
            self.l + other.l,
            self.c + other.c,
            (self.h + other.h) % 360,
        )

    def __sub__(self, other: LCh) -> LCh:
        return LCh(
            self.l - other.l,
            self.c - other.c,
            (self.h - other.h) % 360,
        )

    def __abs__(self) -> LCh:
        return LCh(
            abs(self.l),
            abs(self.c),
            min(abs(self.h), abs(self.h - 360)),
        )


def linear_to_srgb(x: float) -> float:
    return 12.92 * x if x <= 0.0031308 else 1.055 * (x ** (1.0 / 2.4)) - 0.055


def srgb_to_linear(x: float) -> float:
    return x / 12.92 if x <= 0.04045 else ((x + 0.055) / 1.055) ** 2.4


STEP = 0.25

MAX_DIFF = LCh(0.2, 1, 5)

BASE = LCh(1 - STEP, 0, 0)
COLOR = LCh(0, 0.4, 30)

COLOR_SHADES = {
    "dim": LCh(-STEP, 0, 0),
    "normal": LCh(0, 0, -15),
    "bright": LCh(0, 0, +15),
}

NEUTRAL_SHADES = {
    "dim": LCh(-STEP, 0, 0),
    "normal": LCh(0, 0, 0),
    "bright": LCh(STEP, 0, 0),
}

COLORS = {
    "red": LCh(0, 0, 0),
    "yellow": LCh(0, 0, 60),
    "green": LCh(0, 0, 120),
    "cyan": LCh(0, 0, 180),
    "blue": LCh(0, 0, 240),
    "magenta": LCh(0, 0, 300),
}

NEUTRALS = {
    "black": LCh(-STEP * 2, 0, 0),
    "white": LCh(0, 0, 0),
}

PRIMARIES = {
    "background": LCh(0, 0, 0),
    "dim_foreground": BASE + LCh(-STEP, 0, 0),
    "foreground": BASE,
    "bright_foreground": BASE + LCh(STEP, 0, 0),
}


def main():
    data: dict[str, dict[str, LCh]] = {}

    for shade, delta in COLOR_SHADES.items():
        for name, lch in COLORS.items():
            data.setdefault(shade, {})[name] = BASE + delta + lch + COLOR

    for shade, delta in NEUTRAL_SHADES.items():
        for name, lch in NEUTRALS.items():
            data.setdefault(shade, {})[name] = BASE + delta + lch

    for name, lch in PRIMARIES.items():
        data.setdefault("primary", {})[name] = lch

    for shade, colors in data.items():
        print(f"[colors.{shade}]")
        for name, lch in colors.items():
            print(f"{name} = '{lch.to_srgb_hex()}'")
        print()


if __name__ == "__main__":
    main()
