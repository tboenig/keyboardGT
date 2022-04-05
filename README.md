# keyboardGT

The Aletheia document image analysis system offers the possibility to install additional virtual keyboards or to customize them.
This repository offers about 80 keyboards based on the MUFI snapchot for download on the [Github page](https://tboenig.github.io/keyboardGT/overview.html).



## Keyboard Production

The production of the keyboards is done automatically. 
An XSLT stylesheet and a Github action workflow are used.

If you want to create the keyboard on your computer 
- an XSLT processor is installed (Saxon is recommended)
- clone the repo and 
- the following command is necessary.

`java -jar saxon-he.jar -xsl:scripts/keyboard.xsl output=keyboards -s:scripts/keyboard.xsl `

📝 Note: The keybords are are stored in the folder `ghout/keyboards` on your system.

## See Also

- Aletheia https://www.primaresearch.org/tools/Aletheia
- Saxon https://www.saxonica.com/welcome/welcome.xml
