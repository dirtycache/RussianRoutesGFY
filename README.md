# RussianRoutesGFY

Do you want to filter out all prefixes from or through BGP ASes from approximately 5,000 autonomous systems registered in the Russian Federation?

Do you run VyOS and support core team members in Ukraine? Perhaps you find <a href="https://blog.vyos.io/global-security-issue-with-russian-federation-invasion-into-ukraine">Yuriy's post</a> inspiring and wish peace for him and Roman, other team members, as well as their familes, loved ones, friends, and neighbors.  

Here's something you can do. You can exclude most of Russia from your network. Maybe it's not significant.  Maybe you run a really big network.  Either way - your network, your rules.

Either download <b>commands.txt</b> and shove it onto your router or download <b>make-the-list.sh</b> and create your own commands.txt

I suggest deploying it with rancid as it is much too long to paste.  It still takes a very long time for vlogin to complete the deployment of the as-path-list -- roughly 45 to 50 minutes. If anybody wants to make this better/faster please feel free.

<pre>vlogin -x ASPATH-RRGFY.txt <your-router-name></pre>
  
Then reference this as-path-list in a route-map - just be sure the deny rule executes prior to any permit rules you might have.

  <pre>  configure
  set policy route-map MY-ROUTE-MAP rule 1 action deny
  set policy route-map MY-ROUTE-MAP rule 1 match as-path ASPATH-RRGFY
  commit;save;exit</pre>

Finally, apply the route-map on the import side of a BGP neighbor:

<pre>eng@rvyos# show protocols bgp 65012 neighbor 192.0.2.245 
 address-family {
     ipv4-unicast {
         route-map {
             import MY-ROUTE-MAP
         }</pre>

Tested on VyOS 1.3.0 with rancid 3.13 - your mileage may vary, and I'm not responsible if you blow up your BGP routing table.

# Cлава Україні!
