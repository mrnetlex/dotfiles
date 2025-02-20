//!HOOK MAIN
//!BIND HOOKED

const float const_1 = 16.0 / 255.0;
const float const_2 = (255.0 - 16.0) / 255.0;

vec4 hook() {
    vec4 c0 = HOOKED_tex(HOOKED_pos);
    return (c0 * const_2) + const_1;
}
