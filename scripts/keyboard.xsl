<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:pc="http://schema.primaresearch.org/PAGE/gts/pagecontent/2019-07-15"
    xmlns:in="http://www.intern.de" exclude-result-prefixes="#all" version="3.0">
    <xsl:output indent="yes" omit-xml-declaration="yes" method="xml"/>

    <xsl:param name="output"/>
    <xsl:param name="release"/>

    <xsl:variable name="MUFITABLE">
        <xsl:copy-of select="document('../metadata/coding.xml')"/>
    </xsl:variable>


    <xsl:variable name="MUFIEXPORT">
        <xsl:copy-of select="json-to-xml(unparsed-text('https://mufi.info/m.php?p=mufiexport'))"/>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:element name="div">
            <xsl:attribute name="class">keyboard</xsl:attribute>
            <xsl:if test="$output = 'keyboards'">
                <xsl:call-template name="kb"/>
            </xsl:if>
            <xsl:if test="$output = 'tkeyboards'">
                <xsl:call-template name="tkb"/>
            </xsl:if>
            <xsl:if test="$output = 'keytable'">
                <xsl:call-template name="kb-table"/>
            </xsl:if>
        </xsl:element>
    </xsl:template>


    <xsl:template match="$MUFIEXPORT//fn:array" name="kb">
        <xsl:for-each-group select="$MUFIEXPORT//fn:map" group-by="fn:string[@key = 'range']">
            <xsl:sort select="fn:current-grouping-key()"/>
            <xsl:result-document href="ghout/keyboards/{fn:current-grouping-key()}.xml">
                <xsl:element name="Parameters">
                    <xsl:attribute name="name">
                        <xsl:value-of select="fn:current-grouping-key()"/>
                    </xsl:attribute>
                    <xsl:for-each select="fn:current-group()">
                        <xsl:element name="Parameter">
                            <xsl:attribute name="type">4</xsl:attribute>
                            <xsl:attribute name="sortIndex">
                                <xsl:number format="1" start-at="0"/>
                            </xsl:attribute>
                            <xsl:attribute name="version">0</xsl:attribute>
                            <xsl:attribute name="name">Character</xsl:attribute>
                            <xsl:attribute name="readOnly">false</xsl:attribute>
                            <xsl:attribute name="isSet">true</xsl:attribute>
                            <xsl:attribute name="visible">true</xsl:attribute>
                            <xsl:attribute name="value">
                                <xsl:value-of select="fn:string[@key = 'codepoint']"/>
                            </xsl:attribute>
                            <xsl:attribute name="id">
                                <xsl:number format="00001"/>
                            </xsl:attribute>
                            <xsl:attribute name="textType">0</xsl:attribute>
                            <xsl:element name="Description">
                                <xsl:value-of select="fn:string[@key = 'description']"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:result-document>
        </xsl:for-each-group>
    </xsl:template>
    
    
    
    <xsl:template match="$MUFIEXPORT//fn:array" name="tkb">
        <xsl:for-each-group select="$MUFIEXPORT//fn:map" group-by="fn:string[@key = 'range']">
            <xsl:sort select="fn:current-grouping-key()"/>
            <xsl:result-document href="ghout/keyboards/{fn:current-grouping-key()}/virtualKeyboards.xml">
            <xsl:text disable-output-escaping="yes">&lt;?xml version="1.0" encoding="UTF-8"?>&#xD;</xsl:text>
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE properties SYSTEM "http://java.sun.com/dtd/properties.dtd"&gt;</xsl:text>
            <xsl:element name="properties">
            <comment>
                Configure virtual keyboards here.
                The key of every entry is the name of the tab that is added to the GUI. 
                The value of the entry is a list of unicode characters OR a valid unicode range in 4-digit hex-format 
                (i.e. 0080-00FF for Latin-1 supplement) - Note that both, a list of characters and multiple ranges, can be combined 
                into one keyboard by seperating the values with a whitespace!
                The keyboards are sorted by their name in the GUI - add leading numbers to enforce a special order!
                The keyboard was created automatically. The basis was the snapchot of MUFI: The Medieval Unicode Font Initiative (https://mufi.info/m.php?p=mufiexport)
            </comment>
        
            
                  <xsl:element name="entry">
                    <xsl:attribute name="key">
                        <xsl:value-of select="fn:current-grouping-key()"/>
                    </xsl:attribute>
                    <xsl:for-each select="fn:current-group()">U+<xsl:value-of select="fn:string[@key = 'codepoint']"/><xsl:text> </xsl:text></xsl:for-each>
                </xsl:element>
            </xsl:element>
                </xsl:result-document>
        </xsl:for-each-group>
        
        <xsl:result-document href="ghout/keyboards/virtualKeyboards.xml">
            <xsl:text disable-output-escaping="yes">&lt;?xml version="1.0" encoding="UTF-8"?>&#xD;</xsl:text>
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE properties SYSTEM "http://java.sun.com/dtd/properties.dtd"&gt;</xsl:text>
            <xsl:element name="properties">
                <comment>
                    Configure virtual keyboards here.
                    The key of every entry is the name of the tab that is added to the GUI. 
                    The value of the entry is a list of unicode characters OR a valid unicode range in 4-digit hex-format 
                    (i.e. 0080-00FF for Latin-1 supplement) - Note that both, a list of characters and multiple ranges, can be combined 
                    into one keyboard by seperating the values with a whitespace!
                    The keyboards are sorted by their name in the GUI - add leading numbers to enforce a special order!
                    The keyboard was created automatically. The basis was the snapchot of MUFI: The Medieval Unicode Font Initiative (https://mufi.info/m.php?p=mufiexport)
                </comment>
                <xsl:for-each-group select="$MUFIEXPORT//fn:map" group-by="fn:string[@key = 'range']">
                    <xsl:sort select="fn:current-grouping-key()"/>
                    <xsl:element name="entry">
                        <xsl:attribute name="key">
                            <xsl:value-of select="fn:current-grouping-key()"/>
                        </xsl:attribute>
                        <xsl:for-each select="fn:current-group()">U+<xsl:value-of select="fn:string[@key = 'codepoint']"/><xsl:text> </xsl:text></xsl:for-each>
                    </xsl:element>
                </xsl:for-each-group>
            </xsl:element>
        </xsl:result-document>
            
        
    </xsl:template>
    
    
    
    
    

    <xsl:template match="$MUFIEXPORT//fn:array" name="kb-table">
        <link rel="stylesheet" href="table_hide.css"/>
        <link rel="stylesheet" type="text/css"
            href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.css"/>
        <script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.5.1.js"><xsl:text> </xsl:text></script>
        <script charset="utf8" type="text/javascript" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"><xsl:text> </xsl:text></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#table_id').DataTable({
                    "scrollX": "1800px",
                    "scrollCollapse": true,
                    "pagingType": "full_numbers",
                    "ordering": true,
                    "info": true,
                });
            });</script>


        <xsl:element name="h1">Code chart</xsl:element>

        <xsl:element name="p">
            The Aletheia document image analysis system and Transkribus offer the possibility to install additional virtual keyboards or to customize them.
            This repository offers about 80 keyboards based on the data snapchot of
            <a href="https://mufi.info/" target="_blank">MUFI: The Medieval Unicode Font Initiative</a> 
            <a href="https://mufi.info/m.php?p=mufiexport" target="_blank">(MUFI data as json)</a>.
        </xsl:element>
        <xsl:element name="p">Would you like to use the keyboard in Aletheia or in Transkribus. Then download and
            install the necessary virtual keyboard. You can find more information about using
            Virtual Keyboards in the 
               <a href="https://www.primaresearch.org/www/assets/tools/Aletheia%20User%20Guide.pdf#page=91" target="_blank">Aletheia User Guide</a> or
               <a href="https://readcoop.eu/de/glossary/virtual-keyboard/" target="_blank">Transkribus Glossar.</a>
        </xsl:element>
        
        <xsl:element name="h3">Links:</xsl:element>
        <ul><li>MUFI: The Medieval Unicode Font Initiative https://mufi.info/</li>
        <li>Aletheia https://www.primaresearch.org/tools/Aletheia</li>
        <li>Transkribus https://readcoop.eu/transkribus/</li>
        </ul>

        <h2>Recommendation</h2>

        <xsl:element name="p"> We recommended to use the Junicode font. This font supports UNICODE
            and also MUFI encoding. Before you start working with the virtual keyboards in Altheia
            you should have the Junicode font installed on your computer.<br/>
            <ul><xsl:element name="h3">Links:</xsl:element>
                <li><a href="https://junicode.sourceforge.io/" target="_blank">Junicode</a></li>
                <li><a href="https://psb1558.github.io/Junicode-font/" target="_blank">Junicode 2</a></li>
            </ul>
        </xsl:element>


        <h2>Download and Installation</h2>
        <h3>For Aletheia</h3>
        <xsl:element name="p">
            <xsl:element name="strong">Download:</xsl:element> You can either choose a specific
            virtual keyboard from the table and/or download the whole keyboard archive. A virtual
            keyboard is an xml file that you need to import into Alteheia. The keyboard archive is a
            zip file. Before you want to install the keyboards you have to unpack the zip
            file.</xsl:element>
        <xsl:element name="div">
            <xsl:attribute name="class">container</xsl:attribute>
            
            <xsl:element name="div">
                <xsl:attribute name="class">column</xsl:attribute>
                <xsl:element name="h3">Installation:<br/></xsl:element>
                <video width="520" height="440" controls="true">
                    <source src="doc/keyboard.mp4" type="video/mp4"/> Your browser does not support
                    the video tag. </video>
            </xsl:element>
            
            <xsl:element name="div">
                <xsl:attribute name="class">column</xsl:attribute>
                <xsl:element name="h3">Links:</xsl:element>
                <a href="https://github.com/tboenig/keyboardGT/releases/download/v{$release}/keyboardGT-v{$release}.zip">
                    keyboard archiv as zip</a>
            </xsl:element>
        </xsl:element>
         <h3>For Transcribus</h3>
        <xsl:element name="div">
            <xsl:attribute name="class">container</xsl:attribute>
            
            <xsl:element name="div">
                <xsl:attribute name="class">column</xsl:attribute>
            <xsl:element name="p">
                Download the <strong>virtualKeyboards.xml</strong> file and copy it to the program directory of your Transkribus installation. 
                You should archive the existing file. The new virtualKeyboards file replaces this file.
            </xsl:element>
            </xsl:element>
            
            <xsl:element name="div">
                <xsl:attribute name="class">column</xsl:attribute>
                <xsl:element name="h3">Links:</xsl:element>
                <xsl:element name="a">
                    <xsl:attribute name="href">keyboards/virtualKeyboards.xml</xsl:attribute>
                    <xsl:attribute name="target">_blank</xsl:attribute>
                    virtualKeyboards.xml
                </xsl:element>
            </xsl:element>
        
        </xsl:element>
        <hr/>
        
        <xsl:element name="table">
            <xsl:attribute name="id">table_id</xsl:attribute>
            <xsl:element name="thead">
                <xsl:element name="tr">
                    <xsl:element name="th"><xsl:attribute name="style">position: sticky !important; left: 0 !important;</xsl:attribute>Code chart</xsl:element>
                    <xsl:element name="th"><span class="big">&#x2328;</span> Virtual Keyboard Layouts for Aletheia</xsl:element>
                    <xsl:element name="th"><span class="big">&#x2328;</span> Virtual Keyboard Layouts for Transkribus</xsl:element>
                    <xsl:element name="th"><span class="big">&#x1F481;</span> Browse by code chart (Link to MUFI)</xsl:element>
                </xsl:element>
              </xsl:element>
            <xsl:element name="tbody">
                <xsl:for-each-group select="$MUFIEXPORT//fn:map"
                    group-by="fn:string[@key = 'range']">
                    <xsl:sort select="fn:current-grouping-key()"/>
                    <xsl:variable name="link">https://mufi.info/m.php?<xsl:value-of
                            select="$MUFITABLE//coding/code[@id = fn:current-grouping-key()]/@href"
                        /></xsl:variable>
                    <xsl:element name="tr">
                        <xsl:element name="th">
                            <xsl:value-of
                                select="$MUFITABLE//coding/code[@id = fn:current-grouping-key()]"/>
                        </xsl:element>
                        <xsl:element name="td">
                            <xsl:element name="a">
                                <xsl:attribute name="href">keyboards/<xsl:value-of
                                        select="fn:current-grouping-key()"/>.xml</xsl:attribute>
                                <xsl:attribute name="target">_blank</xsl:attribute>
                                <xsl:value-of select="fn:current-grouping-key()"/>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="td">
                            <xsl:element name="a">
                                <xsl:attribute name="href">keyboards/<xsl:value-of
                                    select="fn:current-grouping-key()"/>/virtualKeyboards.xml</xsl:attribute>
                                <xsl:attribute name="target">_blank</xsl:attribute>
                                <xsl:value-of select="fn:current-grouping-key()"/>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="td">
                                <xsl:text disable-output-escaping="yes">&lt;a href="</xsl:text><xsl:value-of
                                    select="$link" disable-output-escaping="yes"/>"
                                target="_blank"<xsl:text disable-output-escaping="yes">&gt;</xsl:text>Browse
                                charts<xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text>
                        </xsl:element>
                        
                    </xsl:element>
                </xsl:for-each-group>
            </xsl:element>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>
