````{verbatim}
 _     _         _       
| |   (_)       | |             \\
| |__  _ _ __ __| |_   _        (o >
| '_ \| | '__/ _` | | | |    \\_//)
| |_) | | | | (_| | |_| |     \_/_)
|_.__/|_|_|  \__,_|\__, |      _|_
                    __/ |
                   |___/

        by Mehrezat Abbas
````

## Project Description

Birdy is a mobile app that turns sound recognition into an outdoor scavenger hunt! The planned app consists of one interface, which allows the user to record audio, see current bird species identification, and access a personal library of previously encountered birds--kind of like a Pokedex. Upon audio input, the app passes the audio file to a Python program via POST request. This program uses BirdNet, a Python-only library for AI bird call recognition, to identify the bird's species and return this information to the app's front-end for display.

In its current state, the app does not support audio recording, and instead demos its functionality via four bird call simulation buttons. These buttons pass pre-existing audio file paths to the bird call identifier and executes the remaining features as intended.

While bird call recognition softwares and apps are previously existent, the purpose of this project is to encourage further exploration, curiosity, and mindfulness by emphasizing the collection of a wide array of bird species encounters. Facilitating such a relationship between an individual and the outdoors is beneficial for both parties. The ideal user, encouraged to become more aware of surrounding nature, grows a personally rewarding appreciation for wildlife and, consequently, becomes an advocate for its preservation. 

Currently, Birdy is only accessible by running its codebase on an emulator. The user must have flutter and an emulator installed before using an IDE to run the interface. Once the app is running, it's simple to navigate. Four buttons simulate four different bird call inputs. Below these is a panel where the last-heard species is displayed. At the bottom, there is a scrollable panel which displays a list of historically encountered birds.

Birdy is a tangible Maker Track product that corresponds with the "Sustainability Hack" and "Failed Hack" overlays.
