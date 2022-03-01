# RussianRoutesGFY

Do you want to filter out all prefixes from or through BGP ASes from approximately 5,000 autonomous systems in Russian Federation?

Do you run VyOS and support core team members in Ukraine?

Either download ASPATH-RRGFY.txt and shove it onto your router or download make-the-list.sh and create your own commands.txt

I suggest with rancid as it is much too long to paste:

vlogin -x ASPATH-RRGFY.txt <your-router-name>)
  
Then reference this as-path-list in a route-map - just be sure the deny rule executes prior to any permit rules you might have.
  
  configure
  set policy route-map MY-ROUTE-MAP rule 1 action deny
  set policy route-map MY-ROUTE-MAP rule 1 match as-path ASPATH-RRGFY
  commit;save;exit
  
Tested on VyOS 1.3.0 with rancid 3.13 - your mileage may vary, and I'm not responsible if you blow up your BGP routing table.

Cлава Україні!
