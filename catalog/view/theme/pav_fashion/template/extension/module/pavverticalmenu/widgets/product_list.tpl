<?php
	$span = 12/$cols;
	$config = $sconfig;
	$theme  = $themename;
	$themeConfig = (array)$config->get('themecontrol');
	$listingConfig = array(
		'category_pzoom'        => 1,
		'quickview'             => 0,
		'show_swap_image'       => 0,
		'product_layout'		=> 'default',
		'enable_paneltool'	    => 0
	);
	$listingConfig = array_merge($listingConfig, $themeConfig );
	$categoryPzoom = $listingConfig['category_pzoom'];
	$quickview     = $listingConfig['quickview'];
	$swapimg       = $listingConfig['show_swap_image'];
	$categoryPzoom = isset($themeConfig['category_pzoom']) ? $themeConfig['category_pzoom']:0; 
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/default.tpl';	
?>
<?php if( $show_title ) { ?>
<div class="widget-heading"><?php echo $heading_title?></div>
<?php } ?>
<div class="widget-product-list <?php echo $addition_cls; ?>">
	<div class="widget-inner">
		<?php foreach ($products as $product) { ?>
		<div class="w-product clearfix col-lg-<?php echo $cols;?> col-md-<?php echo $cols;?> col-sm-12 col-xs-12">
			<?php require( $productLayout );  ?>   
		</div>
		<?php } ?>
	</div>
</div>
