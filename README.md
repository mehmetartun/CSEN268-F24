## Santa Clara University - CSEN268 Fall 2024

### Lecture 9 - With Image Picking and Saving to Gallery

We implemented the `image_picker` package to pick images into a temporary
file both in Web and Android/iOS.  

### Conditional imports

For saving images and displaying images, we implemented two classes `SaveImage` and `DisplayImage`
which needs a separate implementation for Web and Android/iOS. Primarily this is due to the fact
that **Flutter Web** uses the `dart:html` library and for all other platforms `dart:io` library is used.

Packages like `image_picker` uses the cross-platform file package `cross_file` with the object `XFile` returned
as the file object. This has to be handled differently in Web vs Android/iOS (and also MacOS, Windows, etc).

Therefore the typical conditional import structure is as follows:

    save_image.dart
    save_image_other.dart
    save_image_web.dart
    save_image_io.dart

the purpose of `save_image.dart` will be to simply expose one of the specific implementations depending on the platform
where the program is running.

```dart
export 'save_image_other.dart'
    if (dart.library.io) 'save_image_io.dart'
    if (dart.library.html) 'save_image_web.dart'
```

This way the platform specific imports such as `dart:html` or `dart:io` can be hidden in the  files
`save_image_web.dart` and `save_image_io.dart` respectively.

The same goes for displaying images. A file on the local device in **Flutter Web** can be displayed using `Image.network` whereas 
a file  in the local device in all others can be displayed with `Image.file`. A similar conditional import structure is shown here in the definition of the class `DisplayImage`.

### Setting up your environment before the lecture

Each lecture is stored under a separate tag. In your computer do the following

    git clone <Repository Name>
    git pull
    git tag -l

This will list you all the tags in the repository such as

    Lecture4
    Lecture5
    Lecture6
    ...

In order to pull a particular tag to your computer

    git checkout tags/Lecture5_start -b Lecture5_study



