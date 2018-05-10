
<div class="product-block item-default" itemtype="http://schema.org/Product" itemscope>

	<?php if ($product['thumb']) {    ?>
		 <div class="image">
      	<?php if( $product['special'] ) {   ?>
    	<span class="product-label-special label"><span class="special"><?php echo $objlang->get( 'text_sale' ); ?></span></span>
    	<?php } ?>
			<a class="img" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" class="img-responsive" /></a>
		</div>
	<?php } ?>
	
	<div class="product-meta">
		<div class="warp-info">
			<h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
			<?php if( isset($product['description']) ){ ?> 
				<div class="description" itemprop="description"><?php echo utf8_substr( strip_tags($product['description']),0,220);?>...</div>
			<?php } ?>
			<?php if ($product['price']) { ?>
			<div class="price" itemtype="http://schema.org/Offer" itemscope itemprop="offers">
				<?php if (!$product['special']) {  ?>
					<span class="special-price"><?php echo $product['price']; ?></span>
					<?php if( preg_match( '#(\d+).?(\d+)#',  $product['price'], $p ) ) { ?> 
					<meta content="<?php echo $p[0]; ?>" itemprop="price">
					<?php } ?>
				<?php } else { ?>
					<span class="price-new"><?php echo $product['special']; ?></span>
					<span class="price-old"><?php echo $product['price']; ?></span> 
					<?php if( preg_match( '#(\d+).?(\d+)#',  $product['special'], $p ) ) { ?> 
					<meta content="<?php echo $p[0]; ?>" itemprop="price">
					<?php } ?>
				<?php } ?>
				<meta content="<?php // echo $this->currency->getCode(); ?>" itemprop="priceCurrency">
			</div>
			<?php } ?>

		 	  <?php if ( isset( $product['rating']) ) { ?>
              <div class="rating">
                <?php for ($is = 1; $is <= 5; $is++) { ?>
                <?php if ($product['rating'] < $is) { ?>
                <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } else { ?>
                <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                <?php } ?>
                <?php } ?>
              </div>
              <?php } ?>

		</div>

		<div class="product-action"> 				     

		    <?php if( !isset($listingConfig['catalog_mode']) || !$listingConfig['catalog_mode'] ) { ?>
				<div class="cart">
					<i class=" fa fa-shopping-cart"></i>
					<input type="button" value="<?php echo $objlang->get("button_cart"); ?>" onclick="cart.add('<?php echo $product['product_id']; ?>');" class="button" />			
				</div>
			<?php } ?>

		    <div class="wishlist-compare">
			  <a class="wishlist fa fa-heart" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"  title="<?php echo $objlang->get("button_wishlist"); ?>" >
			  </a>
			  <a class="compare fa fa-retweet"  onclick="compare.add('<?php echo $product['product_id']; ?>');" title="<?php echo $objlang->get("button_compare"); ?>" >
			  </a>
			</div>
		</div>
		<?php if ($quickview) { ?>
		<div class="quickview">
			<a class="btn btn-faint iframe-link pav-colorbox" href="<?php echo $ourl->link('themecontrol/product','product_id='.$product['product_id']);?>"  title="<?php echo $objlang->get('quick_view'); ?>" ><span class='fa fa-plus'></span><?php echo $objlang->get('quick_view'); ?></a>
		</div>
		<?php } ?> 
				

	</div>

</div>





