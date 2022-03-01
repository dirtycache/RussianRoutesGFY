#!/usr/bin/env bash

CURL=`which curl`
GREP=`which grep`
SED=`which sed`
AWK=`which awk`
NL=`which nl`
TR=`which tr`
LYNX=`which lynx`
WC=`which wc`
SEQ=`which seq`

ASPATHLIST="ASPATH-RRGFY"

ASNLIST=`$CURL -sk -A "Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/81.0" https://bgp.he.net/country/RU | \
	        $LYNX -stdin -dump -nonumbers | \
		        $GREP "^.*AS[0-9+]" | \
			        $SED 's/AS//g' | \
				        $GREP -v "file" | \
					        $AWK '{print $1}' | \
						        $NL -s " regex '.*_" | \
							        $SED "s/$/_\'/g" | \
								        $SED 's/^/set policy as-path-list ASPATH-RRGFY rule/g' | \
									        $TR -s " "`
echo "configure"

while read ASNREGEX; do 
	RULENUM=`echo $ASNREGEX | $AWK '{print $6}'`
	echo "set policy as-path-list $ASPATHLIST rule $RULENUM action permit" 
	echo "$ASNREGEX"
done <<< $ASNLIST

echo "commit"
echo "save"
echo "exit"
