Consignments
============

This extension adds consignment functionality to Spree.  It allows you to assign a consignor to each product and set a commission based on a percentage of sales price.  The consignment is attached to the product table so actual commissions can be determined for each line item.  
 
Installation
============

1. Install Spree (Requires 0.10.0 or greater).

2. Install this extension

      script/extension install git://github.com/pzupan/spree-consignments.git

3. Run pending migrations

      rake db:migrate

You will need to go to the admin site and enter at least one consignor, then you will be able to set up consignments on each product.


Additional Notes
================

This extension currently only calculates a commission based on a percentage of sales price.  The intent is to extend the commission to calculate a flat rate or a percentage of either sales, cost or master price.  This extension is currently in production on one site.  