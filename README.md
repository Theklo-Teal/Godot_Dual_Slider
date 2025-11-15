For Paracortical Initiative, 2025, Diogo "Theklo" Duarte

Other projects:
https://bsky.app/profile/diogo-duarte.bsky.social
https://diogo-duarte.itch.io/
https://github.com/Theklo-Teal


# DESCRIPTION
A custom slider node for use in the Godot Engine, with two scroll values enabling the control of a span in a range.

# INSTALLATION
This isn't technically a Godot Plugin, it doesn't use the special Plugin features of the Editor, so don't put it inside the "plugin" folder. The folder of the tool can be anywhere else you want, though, but I suggest having it in a "modules" folder.

After that, the «class_name DualSlider» registers the tool so you can add it to a project like you add any Godot node. There's the horizontal and vertical style of slider.

# USAGE
There's a «minim» and «maxim» range values, like in the regular slider. But instead of «value», there is the «lower» and «upper» thresholds. The code should be able to keep lower a lesser value than upper, but you can also have «min_span» keeping the thresholds from getting too close together.

You may connect a signal that is emitted when the thresholds are being dragged and a signal when the thresholds are relased into new values.


