usingnamespace @cImport({
    @cInclude("SDL2/SDL.h");
});
const panic = @import("std").debug.panic;
pub const event = @import("sdl/event.zig");

// Errors
pub const SdlError = error{
    WindowCreation,
    GlContextCreation,
    NoOpenGlContext,
    NoOpenGlAttachedToWindow,
};
pub const getError = SDL_GetError;

// Type Definitions
pub const Window = SDL_Window;
pub const GlContext = SDL_GLContext;
pub const Event = SDL_Event;

// Init Variables
pub const init_timer = SDL_INIT_TIMER;
pub const init_audio = SDL_INIT_AUDIO;
pub const init_video = SDL_INIT_VIDEO;
pub const init_joystick = SDL_INIT_JOYSTICK;
pub const init_haptic = SDL_INIT_HAPTIC;
pub const init_gamecontroller = SDL_INIT_GAMECONTROLLER;
pub const init_events = SDL_INIT_EVENTS;
pub const init_everything = SDL_INIT_EVERYTHING;
pub const init_noparachute = SDL_INIT_NOPARACHUTE;

// Function
pub const init = SDL_Init;
pub const quit = SDL_Quit;
pub const delay = SDL_Delay;
pub const pollEvent = SDL_PollEvent;

// Window Flags
pub const window_position_centered = SDL_WINDOWPOS_CENTERED;
pub const window_position_undefined = SDL_WINDOWPOS_UNDEFINED;
pub const window_fullscreen = SDL_WINDOW_FULLSCREEN;
pub const window_fullscreen_desktop = SDL_WINDOW_FULLSCREEN_DESKTOP;
pub const window_opengl = SDL_WINDOW_OPENGL;
pub const window_shown = SDL_WINDOW_SHOWN;
pub const window_hidden = SDL_WINDOW_HIDDEN;
pub const window_borderless = SDL_WINDOW_BORDERLESS;
pub const window_resizable = SDL_WINDOW_RESIZABLE;
pub const window_minimized = SDL_WINDOW_MINIMIZED;
pub const window_maximized = SDL_WINDOW_MAXIMIZED;
pub const window_input_grabbed = SDL_WINDOW_INPUT_GRABBED;
pub const window_input_focus = SDL_WINDOW_INPUT_FOCUS;
pub const window_mouse_focus = SDL_WINDOW_MOUSE_FOCUS;
pub const window_foreign = SDL_WINDOW_FOREIGN;

// OpenGL Attribute Enum
pub const gl_red_size = @intToEnum(SDL_GLattr, SDL_GL_RED_SIZE);
pub const gl_green_size = @intToEnum(SDL_GLattr, SDL_GL_GREEN_SIZE);
pub const gl_blue_size = @intToEnum(SDL_GLattr, SDL_GL_BLUE_SIZE);
pub const gl_alpha_size = @intToEnum(SDL_GLattr, SDL_GL_ALPHA_SIZE);
pub const gl_buffer_size = @intToEnum(SDL_GLattr, SDL_GL_BUFFER_SIZE);
pub const gl_doublebuffer = @intToEnum(SDL_GLattr, SDL_GL_DOUBLEBUFFER);
pub const gl_depth_size = @intToEnum(SDL_GLattr, SDL_GL_DEPTH_SIZE);
pub const gl_stencil_size = @intToEnum(SDL_GLattr, SDL_GL_STENCIL_SIZE);
pub const gl_accum_red_size = @intToEnum(SDL_GLattr, SDL_GL_ACCUM_RED_SIZE);
pub const gl_accum_green_size = @intToEnum(SDL_GLattr, SDL_GL_ACCUM_GREEN_SIZE);
pub const gl_accum_blue_size = @intToEnum(SDL_GLattr, SDL_GL_ACCUM_BLUE_SIZE);
pub const gl_accum_alpha_size = @intToEnum(SDL_GLattr, SDL_GL_ACCUM_ALPHA_SIZE);
pub const gl_stereo = @intToEnum(SDL_GLattr, SDL_GL_STEREO);
pub const gl_multisamplebuffers = @intToEnum(SDL_GLattr, SDL_GL_MULTISAMPLEBUFFERS);
pub const gl_multisamplesamples = @intToEnum(SDL_GLattr, SDL_GL_MULTISAMPLESAMPLES);
pub const gl_accelerated_visual = @intToEnum(SDL_GLattr, SDL_GL_ACCELERATED_VISUAL);
pub const gl_retained_backing = @intToEnum(SDL_GLattr, SDL_GL_RETAINED_BACKING);
pub const gl_context_major_version = @intToEnum(SDL_GLattr, SDL_GL_CONTEXT_MAJOR_VERSION);
pub const gl_context_minor_version = @intToEnum(SDL_GLattr, SDL_GL_CONTEXT_MINOR_VERSION);
pub const gl_context_flags = @intToEnum(SDL_GLattr, SDL_GL_CONTEXT_FLAGS);
pub const gl_context_profile_mask = @intToEnum(SDL_GLattr, SDL_GL_CONTEXT_PROFILE_MASK);
pub const gl_share_with_current_context = @intToEnum(SDL_GLattr, SDL_GL_SHARE_WITH_CURRENT_CONTEXT);

pub const gl_context_profile_core = SDL_GL_CONTEXT_PROFILE_CORE;
pub const gl_context_profile_compatibility = SDL_GL_CONTEXT_PROFILE_COMPATIBILITY;
pub const gl_context_profile_es = SDL_GL_CONTEXT_PROFILE_ES;

// OpenGL Functions
pub const BindGlTexture = SDL_GL_BindTexture;
pub fn CreateGlContext(window: *Window) !GlContext {
    if (SDL_GL_CreateContext(window)) |context| {
        return context;
    }
    return SdlError.GlContextCreation;
}
pub const DeleteGlContext = SDL_GL_DeleteContext;
pub const ExtensionGlSupported = SDL_GL_ExtensionSupported;
pub const GetGlAttribute = SDL_GL_GetAttribute;

pub fn GetGlCurrentContext() *GlContext {
    if (SDL_GL_GetCurrentContext()) |context| {
        return context;
    }
    return SdlError.NoOpenGlContext;
}

pub fn GetGlCurrentWindow() *GlContext {
    if (SDL_GL_GetCurrentWindow()) |window| {
        return window;
    }
    return SdlError.NoOpenGlAttachedToWindow;
}
pub const getGlDrawableSize = SDL_GL_GetDrawableSize;
pub const getGlProcAddress = SDL_GL_GetProcAddress;
pub const getGlSwapInterval = SDL_GL_GetSwapInterval;
pub const loadGlLibrary = SDL_GL_LoadLibrary;
pub const makeGlCurrent = SDL_GL_MakeCurrent;
pub const resetGlAttributes = SDL_GL_ResetAttributes;
pub const setGlAttribute = SDL_GL_SetAttribute;
pub const setGlSwapInterval = SDL_GL_SetSwapInterval;
pub const swapGlWindow = SDL_GL_SwapWindow;
pub const unbindGlTexture = SDL_GL_UnbindTexture;
pub const unloadGlLibrary = SDL_GL_UnloadLibrary;

// Window Creation Functions
pub fn createWindow(title: [*c]const u8, x: i32, y: i32, w: i32, h: i32, flags: u32) !*Window {
    if (SDL_CreateWindow(title, x, y, w, h, flags)) |window| {
        return window;
    }
    return SdlError.WindowCreation;
}

pub const destroyWindow = SDL_DestroyWindow;
pub const getTicks = SDL_GetTicks;

pub inline fn ASSERT_OK(result: var) void {
    if (result == 0) return;
    panic("SDL Panic: {}\n", .{getError()});
}
