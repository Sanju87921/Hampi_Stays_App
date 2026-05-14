# HampiStays | Official Frontend Design System & UI Reference
**Version:** 1.0 (Cinematic Luxury)  
**Target Platform:** Flutter (iOS/Android)  
**Design Ethos:** Ancient Sanctuary, Modern Precision

---

## 1. 🎨 Color System (The "Earth & Stone" Palette)
Our colors are inspired by the boulders of Hampi at dawn. Avoid "Digital Black" (#000) or "Pure White" (#FFF). Use these HSL-derived tokens for depth.

### Core Brand Colors
| Token | HEX | Usage |
| :--- | :--- | :--- |
| **Warm Ivory** | `#FDFBF7` | Main background surface, soft and inviting. |
| **Sandstone** | `#F3EFE7` | Secondary surfaces, cards, and subtle dividers. |
| **Muted Gold** | `#C8A96B` | Primary action color, accents, and shimmers. |
| **Deep Navy** | `#020617` | High-contrast text, primary buttons, and authority. |
| **Heritage Cream** | `#FAF7F2` | Input fields and glassmorphic base. |
| **Clay Red** | `#92400E` | Subtle warnings or cultural highlight accents. |

### Semantic Gradients (Flutter: `LinearGradient`)
*   **Luxury Gold**: `[#C8A96B, #D4AF37, #B8860B]` (Used for success states and premium buttons)
*   **Midnight Glass**: `[#020617.withOpacity(0.05), #020617.withOpacity(0.1)]` (Used for containers)
*   **Dawn Light**: `[#FFFFFF.withOpacity(0.8), #FDFBF7.withOpacity(0.5)]` (Glassmorphism overlay)

---

## 2. ✍️ Typography System (The Editorial Scale)
We use a "High-Contrast Serif" for headings and a "Geometric Sans" for data to ensure the app feels like a luxury travel magazine.

### Typeface Selection
*   **Display (Serif)**: *Playfair Display* or *Prata* (Elegant, High-contrast)
*   **Body (Sans)**: *Inter* or *Outfit* (Modern, Highly legible)

### Typography Scale (Flutter: `TextStyle`)
| Role | Font | Size | Weight | Tracking |
| :--- | :--- | :--- | :--- | :--- |
| **Hero Heading** | Serif | 42px | Bold | -0.02em |
| **Page Title** | Serif | 32px | SemiBold | -0.01em |
| **Section Header**| Sans | 14px | Black | 0.2em (Uppercase) |
| **Body Large** | Sans | 16px | Regular | 0.01em |
| **Body Small** | Sans | 13px | Medium | 0.02em |
| **Button Label** | Sans | 14px | Bold | 0.1em (Uppercase) |

---

## 3. 💎 UI Style Guide (The Depth System)
HampiStays is not "Flat". It uses **Physical Depth** and **Optical Blurs**.

### Glassmorphism Tokens
*   **Blur Strength**: 12px - 20px (`BackdropFilter`)
*   **Border**: 1px Solid `#FFFFFF` with 20% opacity.
*   **Shadow (The "Hospitality Shadow")**: 
    *   `BoxShadow(offset: Offset(0, 10), blur: 30, color: Color(0x1A020617))`

### Border Radius Scale
*   **Buttons/Inputs**: 16px (Soft Square)
*   **Cards**: 32px (Premium Large)
*   **Modals/Sheets**: 40px (Top edges)

---

## 4. 📱 Mobile Component System

### A. The "Slide-to-Continue" Auth Slider
The signature HampiStays interaction.
*   **Handle**: Circle with `Deep Navy` icon.
*   **Track**: `Warm Ivory` with a gold gradient "Fill" that grows as you slide.
*   **Flutter Implementation**: Use `GestureDetector` with `HorizontalDrag` updates, constrained by the container width.

### B. Resort Cinematic Cards
*   **Image**: 16:9 ratio with `top-radius: 32px`.
*   **Overlay**: Subtle bottom-to-top black gradient (0% to 60%).
*   **Interaction**: Subtle scaling (+2%) on long-press.
*   **Visual**: Price floats in a glassmorphic pill in the top-right.

### C. Bottom Navigation (The "Luxury Dock")
*   **Floating Design**: 20px bottom margin, 16px side margin.
*   **Material**: `BackdropFilter` glassmorphism.
*   **Active State**: Muted Gold dot indicator below the icon.

---

## 5. 🎬 Premium Animation System (Apple-Level Motion)
Movement in HampiStays is **Inertial** and **Weighted**.

### The "Luxury Curve" (Custom Easing)
*   **Flutter**: `Cubic(0.16, 1, 0.3, 1)` (Quartic Out)
*   **Behavior**: Rapid start, very long smooth deceleration.

### Standard Timings
*   **Micro-interactions**: 200ms
*   **Page Transitions**: 600ms (Staggered fade + slide)
*   **Success Locks**: 800ms (Inertial spring)

### Micro-interaction Philosophy
*   **Tap Feedback**: Never use the default "Ripple". Use a subtle `Transform.scale(0.98)` on `onTapDown`.
*   **Haptics**: Trigger `HapticFeedback.lightImpact()` exactly when a slider reaches 100% completion.

---

## 6. 🖼️ Page Design Reference Models

### Onboarding
*   **Background**: High-definition drone footage or full-bleed high-res image.
*   **UX**: Minimalist "Get Started" button using the Slide-to-Continue mechanic.

### Resort Details (The "Immersive View")
*   **Hero**: Parallax image header (300px height).
*   **Sticky Header**: Name and "Book Now" appear only after scrolling past the hero.
*   **Booking Widget**: Floating glass container at the bottom of the screen.

---

## 7. 📏 Design Tokens (The Constant Scale)

| Type | Scale | Values (px) |
| :--- | :--- | :--- |
| **Spacing** | 4px | 4, 8, 12, 16, 24, 32, 48, 64 |
| **Shadows** | Luxury | `Elevation.low: 5, Elevation.high: 25` |
| **Opacity** | Cinematic| `Subtle: 0.05, Glass: 0.15, Muted: 0.6` |

---

## 8. 🛠️ Implementation Checklist (Flutter)
1.  [ ] **Global Theme**: Implement `ThemeData` using `Color(0xFFFDFBF7)` as `scaffoldBackgroundColor`.
2.  [ ] **Custom Painter**: Use `CustomPainter` for the gradient track fills in sliders.
3.  [ ] **Shimmer Effect**: Use the `shimmer` package for luxury loaders, with a gold-to-ivory gradient.
4.  [ ] **Haptics**: Integrate `services.dart` to trigger haptic feedback on every successful "Slide-to-Unlock".

---

> [!TIP]
> **Luxury Secret**: On the Home Screen, use a very slow (30-second) `AnimatedContainer` gradient shift for the background to make the app feel "alive" and atmospheric.
