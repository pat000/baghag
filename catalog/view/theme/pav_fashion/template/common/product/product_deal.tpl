<div class="product-block">
	<div class="image">
		<?php if( $product['special'] ):  ?>
			<div class="product-label-special label"><?php echo $objlang->get( 'text_sale' ); ?></div>
		<?php endif; ?>
		<a href="<?php echo $product['href']; ?>">
			<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" />
		</a>
	</div>

	<div class="product-meta">
		<div class="warp-info">
			<h4 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h4>
			<p class="description"><?php echo $product['description']; ?></p>
			<?php if ($product['rating']) { ?>
			<div class="rating">
				<?php for ($i = 1; $i <= 5; $i++) { ?>
				<?php if ($product['rating'] < $i) { ?>
				<span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
				<?php } else { ?>
				<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
				<?php } ?>
				<?php } ?>
			</div>
			<?php } ?>
			<?php if ($product['price']) { ?>
			<p class="price">
				<?php if (!$product['special']) { ?>
				<?php echo $product['price']; ?>
				<?php } else { ?>
				<span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
				<?php } ?>
				<?php if (!empty($product['tax'])) { ?>
				<span class="price-tax"><?php echo $objlang->get('text_tax'); ?> <?php echo $product['tax']; ?></span>
				<?php } ?>
			</p>
			<?php } ?>
		</div>
	</div>

	<div class="group-deals">
		<div class="deal-collection text-left">
			<div class="deal_detail">
				<ul>
					<li>
						<span><?php echo $objlang->get("text_discount");?></span>
						<span class="deal_detail_num"><?php echo $product['deal_discount'];?>%</span>
					</li>
					<li>
						<span><?php echo $objlang->get("text_you_save");?></span>
						<span class="deal_detail_num"><span class="price"><?php echo $product["save_price"]; ?></span></span>
					</li>
					<li>
						<span><?php echo $objlang->get("text_bought");?></span>
						<span class="deal_detail_num"><?php echo $product['bought'];?></span>
					</li>
				</ul>
			</div>
			<div class="deal-qty-box">
				<?php echo sprintf($objlang->get("text_quantity_deal"), $product["quantity"]);?>
			</div>

			<div class="item-detail">
				<div class="timer-explain">(<?php echo date($objlang->get("date_format_short"), strtotime($product['date_end_string'])); ?>)</div>
			</div>
		</div>
		<div id="item<?php echo $module; ?>countdown_<?php echo $product['product_id']; ?>" class="item-countdown"></div>

		<div class="product-action">											
			<div class="cart">
				<i class=" fa fa-shopping-cart"></i>
				<input type="button" value="<?php echo $button_cart; ?>" onclick="cart.add('<?php echo $product['product_id']; ?>');" class="button" />			
			</div>
			<div class="wishlist-compare">
			  <a class="wishlist" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"  title="<?php echo $objlang->get("button_wishlist"); ?>" >
			  	<i class="fa fa-heart"></i>
			  </a>
			  <a class="compare" onclick="compare.add('<?php echo $product['product_id']; ?>');" title="<?php echo $objlang->get("button_compare"); ?>" >
			  	<i class="fa fa-retweet"></i>
			  </a>
			</div>			
		</div>
	</div>


</div>



<script type="text/javascript">
	jQuery(document).ready(function($){
		$("#item<?php echo $module; ?>countdown_<?php echo $product['product_id']; ?>").lofCountDown({
			formatStyle:2,
			TargetDate:"<?php echo date('m/d/Y G:i:s', strtotime($product['date_end_string'])); ?>",
			DisplayFormat:"<ul><li>%%D%% <div><?php echo $objlang->get("text_days");?></div></li><li> %%H%% <div><?php echo $objlang->get("text_hours");?></div></li><li> %%M%% <div><?php echo $objlang->get("text_minutes");?></div></li><li> %%S%% <div><?php echo $objlang->get("text_seconds");?></div></li></ul>",
			FinishMessage: "<?php echo $objlang->get('text_finish');?>"
		});
	});
</script>