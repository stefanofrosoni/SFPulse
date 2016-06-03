SFPulse
===========
![Language](https://img.shields.io/badge/language-Swift%202-orange.svg)
![License](https://img.shields.io/packagist/l/doctrine/orm.svg)

This allows to add a customizable CALayer pulse effect to any arbitrary UIView.
Completely written in Swift.
 
![Demo](Demo.gif?raw=true "Optional Title") 

#How to use

1. Add SFPulse.swift into your project
2. Just initiate (e.g. with its custom constructor) and add to your view layer.

**let sfPulse = SFPulse(radius: 80, position: imageView.center, numberOfLayers: 2, animationDuration: 4.0, pulseColor: .orangeColor())**  
 
 **view.layer.insertSublayer(sfPulse, below: imageView.layer)**


#Customizations

##radius
Use the radius property to set the max size of the pulse effect.

##position
CGPoint position of the customizable layer.

##pulseColor
UIColor for the pulse effect

##animationDuration
Use the animationDuration property to set the duration of the animations cycle.

##numberOfLayers
Use the numberOfLayers property to set the number of layer (waves) in the pulse effect.


How to Contribute
======
1. Fork it.
2. Create your feature branch (git checkout -b new-feature).
3. Commit your changes (git commit -am 'Added new-feature').
4. Push to the branch (git push origin new-feature).
5. Create new Pull Request.


## About

Written from Scratch in Swift.
Created by
Stefano Frosoni, [@stefanofrosoni](http://twitter.com/stefanofrosoni)

Inspired by [PulsingHalo](https://github.com/shu223/PulsingHalo).

## License

See [LICENCE](LICENCE).