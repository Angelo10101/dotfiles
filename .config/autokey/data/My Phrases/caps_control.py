import time
from pynput import keyboard

# Global variables
caps_held = False
last_cap_tap = 0
double_tap_time = 400  # milliseconds
spam_delay = 50  # milliseconds
mod_key_arr = ['ctrl', 'alt', 'shift', 'win']

# Keyboard controller
keyboard_controller = keyboard.Controller()

def on_press(key):
    global caps_held, last_cap_tap

    try:
        # Check if Caps Lock is pressed
        if key == keyboard.Key.caps_lock:
            current_time = int(time.time() * 1000)
            if current_time - last_cap_tap < double_tap_time:
                toggle_caps_state()
                last_cap_tap = 0
            else:
                last_cap_tap = current_time
            caps_held = True
            return False  # Suppress Caps Lock key press

        # Handle navigation keys when Caps Lock is held
        elif caps_held:
            if hasattr(key, 'char'):  # Check if the key has a character representation
                if key.char == 'h':
                    keyboard_controller.press(keyboard.Key.left)
                    keyboard_controller.release(keyboard.Key.left)
                    return False  # Suppress 'h' key press
                elif key.char == 'j':
                    keyboard_controller.press(keyboard.Key.down)
                    keyboard_controller.release(keyboard.Key.down)
                    return False  # Suppress 'j' key press
                elif key.char == 'k':
                    keyboard_controller.press(keyboard.Key.up)
                    keyboard_controller.release(keyboard.Key.up)
                    return False  # Suppress 'k' key press
                elif key.char == 'l':
                    keyboard_controller.press(keyboard.Key.right)
                    keyboard_controller.release(keyboard.Key.right)
                    return False  # Suppress 'l' key press

        # Handle modifier keys
        if caps_held:
            if hasattr(key, 'char'):
                if key.char == 'a':
                    keyboard_controller.press(keyboard.Key.shift)
                    return False  # Suppress 'a' key press
                elif key.char == 's':
                    keyboard_controller.press(keyboard.Key.ctrl)
                    return False  # Suppress 's' key press
                elif key.char == 'd':
                    keyboard_controller.press(keyboard.Key.alt)
                    return False  # Suppress 'd' key press

    except AttributeError:
        pass

    return True  # Allow other key presses to proceed normally

def on_release(key):
    global caps_held

    try:
        # Release Caps Lock state
        if key == keyboard.Key.caps_lock:
            caps_held = False

        # Release modifier keys when Caps Lock is released
        if not caps_held:
            if hasattr(key, 'char'):
                if key.char == 'a':
                    keyboard_controller.release(keyboard.Key.shift)
                elif key.char == 's':
                    keyboard_controller.release(keyboard.Key.ctrl)
                elif key.char == 'd':
                    keyboard_controller.release(keyboard.Key.alt)

    except AttributeError:
        pass

    return True  # Allow other key releases to proceed normally

def toggle_caps_state():
    # Simulate toggling Caps Lock state
    with keyboard.Controller() as controller:
        controller.tap(keyboard.Key.caps_lock)

# Start listening for key events
with keyboard.Listener(on_press=on_press, on_release=on_release) as listener:
    listener.join()