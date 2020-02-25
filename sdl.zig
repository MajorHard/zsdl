const panic = @import("std").debug.panic;
pub const c = @import("c.zig");
pub const event = @import("sdl/event.zig");

// Errors
pub const SdlError = error{
    WindowCreation,
    GlContextCreation,
    NoOpenGlContext,
    NoOpenGlAttachedToWindow,
};
pub const getError = c.SDL_GetError;

// Hints
pub const HintPriority = enum {
    Default,
    Normal,
    Override,

    pub fn toC(self: HintPriority) c.SDL_HintPriority  {
        return switch(self) {
            .Default => c.SDL_HintPriority.SDL_HINT_DEFAULT,
            .Normal => c.SDL_HintPriority.SDL_HINT_NORMAL,
            .Override => c.SDL_HintPriority.SDL_HINT_OVERRIDE,
        };
    }
};

pub fn setHintWithPriority(name: [*c]const u8, value: [*c]const u8, priority: HintPriority) bool {
    switch(c.SDL_SetHintWithPriority(name, value, priority.toC())) {
        .SDL_FALSE => return false,
        .SDL_TRUE => return true,
        else => unreachable,
    }
}
// Type Definitions
pub const Window = c.SDL_Window;
pub const GlContext = c.SDL_GLContext;
pub const Event = c.SDL_Event;

// Init Variables
pub const init_timer = c.SDL_INIT_TIMER;
pub const init_audio = c.SDL_INIT_AUDIO;
pub const init_video = c.SDL_INIT_VIDEO;
pub const init_joystick = c.SDL_INIT_JOYSTICK;
pub const init_haptic = c.SDL_INIT_HAPTIC;
pub const init_gamecontroller = c.SDL_INIT_GAMECONTROLLER;
pub const init_events = c.SDL_INIT_EVENTS;
pub const init_everything = c.SDL_INIT_EVERYTHING;
pub const init_noparachute = c.SDL_INIT_NOPARACHUTE;

// Function
pub const init = c.SDL_Init;
pub const quit = c.SDL_Quit;
pub const delay = c.SDL_Delay;
pub const pollEvent = c.SDL_PollEvent;

// Window Flags
pub const window_position_centered = c.SDL_WINDOWPOS_CENTERED;
pub const window_position_undefined = c.SDL_WINDOWPOS_UNDEFINED;
pub const window_fullscreen = c.SDL_WINDOW_FULLSCREEN;
pub const window_fullscreen_desktop = c.SDL_WINDOW_FULLSCREEN_DESKTOP;
pub const window_opengl = c.SDL_WINDOW_OPENGL;
pub const window_shown = c.SDL_WINDOW_SHOWN;
pub const window_hidden = c.SDL_WINDOW_HIDDEN;
pub const window_borderless = c.SDL_WINDOW_BORDERLESS;
pub const window_resizable = c.SDL_WINDOW_RESIZABLE;
pub const window_minimized = c.SDL_WINDOW_MINIMIZED;
pub const window_maximized = c.SDL_WINDOW_MAXIMIZED;
pub const window_input_grabbed = c.SDL_WINDOW_INPUT_GRABBED;
pub const window_input_focus = c.SDL_WINDOW_INPUT_FOCUS;
pub const window_mouse_focus = c.SDL_WINDOW_MOUSE_FOCUS;
pub const window_foreign = c.SDL_WINDOW_FOREIGN;

// OpenGL Attribute Enum
pub const gl_red_size = @intToEnum(c.SDL_GLattr, c.SDL_GL_RED_SIZE);
pub const gl_green_size = @intToEnum(c.SDL_GLattr, c.SDL_GL_GREEN_SIZE);
pub const gl_blue_size = @intToEnum(c.SDL_GLattr, c.SDL_GL_BLUE_SIZE);
pub const gl_alpha_size = @intToEnum(c.SDL_GLattr, c.SDL_GL_ALPHA_SIZE);
pub const gl_buffer_size = @intToEnum(c.SDL_GLattr, c.SDL_GL_BUFFER_SIZE);
pub const gl_doublebuffer = @intToEnum(c.SDL_GLattr, c.SDL_GL_DOUBLEBUFFER);
pub const gl_depth_size = @intToEnum(c.SDL_GLattr, c.SDL_GL_DEPTH_SIZE);
pub const gl_stencil_size = @intToEnum(c.SDL_GLattr, c.SDL_GL_STENCIL_SIZE);
pub const gl_accum_red_size = @intToEnum(c.SDL_GLattr, c.SDL_GL_ACCUM_RED_SIZE);
pub const gl_accum_green_size = @intToEnum(c.SDL_GLattr, c.SDL_GL_ACCUM_GREEN_SIZE);
pub const gl_accum_blue_size = @intToEnum(c.SDL_GLattr, c.SDL_GL_ACCUM_BLUE_SIZE);
pub const gl_accum_alpha_size = @intToEnum(c.SDL_GLattr, c.SDL_GL_ACCUM_ALPHA_SIZE);
pub const gl_stereo = @intToEnum(c.SDL_GLattr, c.SDL_GL_STEREO);
pub const gl_multisamplebuffers = @intToEnum(c.SDL_GLattr, c.SDL_GL_MULTISAMPLEBUFFERS);
pub const gl_multisamplesamples = @intToEnum(c.SDL_GLattr, c.SDL_GL_MULTISAMPLESAMPLES);
pub const gl_accelerated_visual = @intToEnum(c.SDL_GLattr, c.SDL_GL_ACCELERATED_VISUAL);
pub const gl_retained_backing = @intToEnum(c.SDL_GLattr, c.SDL_GL_RETAINED_BACKING);
pub const gl_context_major_version = @intToEnum(c.SDL_GLattr, c.SDL_GL_CONTEXT_MAJOR_VERSION);
pub const gl_context_minor_version = @intToEnum(c.SDL_GLattr, c.SDL_GL_CONTEXT_MINOR_VERSION);
pub const gl_context_flags = @intToEnum(c.SDL_GLattr, c.SDL_GL_CONTEXT_FLAGS);
pub const gl_context_profile_mask = @intToEnum(c.SDL_GLattr, c.SDL_GL_CONTEXT_PROFILE_MASK);
pub const gl_share_with_current_context = @intToEnum(c.SDL_GLattr, c.SDL_GL_SHARE_WITH_CURRENT_CONTEXT);

pub const gl_context_profile_core = c.SDL_GL_CONTEXT_PROFILE_CORE;
pub const gl_context_profile_compatibility = c.SDL_GL_CONTEXT_PROFILE_COMPATIBILITY;
pub const gl_context_profile_es = c.SDL_GL_CONTEXT_PROFILE_ES;

// OpenGL Functions
pub const BindGlTexture = c.SDL_GL_BindTexture;
pub fn CreateGlContext(window: *Window) !GlContext {
    if (c.SDL_GL_CreateContext(window)) |context| {
        return context;
    }
    return SdlError.GlContextCreation;
}
pub const DeleteGlContext = c.SDL_GL_DeleteContext;
pub const ExtensionGlSupported = c.SDL_GL_ExtensionSupported;
pub const GetGlAttribute = c.SDL_GL_GetAttribute;

pub fn GetGlCurrentContext() *GlContext {
    if (c.SDL_GL_GetCurrentContext()) |context| {
        return context;
    }
    return SdlError.NoOpenGlContext;
}

pub fn GetGlCurrentWindow() *GlContext {
    if (c.SDL_GL_GetCurrentWindow()) |window| {
        return window;
    }
    return SdlError.NoOpenGlAttachedToWindow;
}
pub const getGlDrawableSize = c.SDL_GL_GetDrawableSize;
pub const getGlProcAddress = c.SDL_GL_GetProcAddress;
pub const getGlSwapInterval = c.SDL_GL_GetSwapInterval;
pub const loadGlLibrary = c.SDL_GL_LoadLibrary;
pub const makeGlCurrent = c.SDL_GL_MakeCurrent;
pub const resetGlAttributes = c.SDL_GL_ResetAttributes;
pub const setGlAttribute = c.SDL_GL_SetAttribute;
pub const setGlSwapInterval = c.SDL_GL_SetSwapInterval;
pub const swapGlWindow = c.SDL_GL_SwapWindow;
pub const unbindGlTexture = c.SDL_GL_UnbindTexture;
pub const unloadGlLibrary = c.SDL_GL_UnloadLibrary;

// Window Creation Functions
pub fn createWindow(title: [*c]const u8, x: i32, y: i32, w: i32, h: i32, flags: u32) !*Window {
    if (c.SDL_CreateWindow(title, x, y, w, h, flags)) |window| {
        return window;
    }
    return SdlError.WindowCreation;
}

pub const destroyWindow = c.SDL_DestroyWindow;
pub const getTicks = c.SDL_GetTicks;

pub inline fn ASSERT_OK(result: var, message: []const u8) void {
    if (result == 0) return;
    panic("SDL Error: {} - {}\n", .{ message, getError()});
}
