# CoreImagePlay

Playing around with CoreImage + some Metal on iOS.

## The goal:
* This project is a stepping stone to remove dependency on the `GPUImage` framework used in another project I'm involved in.
* I am simply replicating some of the functionality that `GPUImage` offered using `CoreImage`, `AVFoundation`, `Metal` etc.

### To dos:
* Filter video on live view from a capture device
* Capture video and save
* Filter a video for export
* Handle export
* Anwer the following Q: Who should be in charge of cropping the final output image? The filter or the player.
* Turn this into a framework.
