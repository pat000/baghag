<?php
/******************************************************
 * @package Pav Product Tabs module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2012 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

	$span = 12/$cols;
	$active = 'latest';
	$id = rand(1,9)+rand();

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

	$span = 12/$cols;

	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';	
	if( !is_file($productLayout) ){
		$listingConfig['product_layout'] = 'default';
	}
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';	

	//echo "<pre>"; print_r($tabs); die;
?>
<div class="box producttabs  <?php echo $module_class;?> ">
	<div class="tab-nav">
		<ul class="nav nav-tabs bullet" id="producttabs<?php echo $id;?>">
			<?php foreach( $tabs as $tab => $products ) { if( empty($products) ){ continue;}  ?>
				 <li><a href="#tab-<?php echo $tab.$id;?>" data-toggle="tab"><?php echo $objlang->get('text_'.$tab)?></a></li>
			<?php } ?>
		</ul>
    </div>



	<div class="tab-content box-content">
		<?php foreach( $tabs as $tab => $products ) {
				if( empty($products) ){ continue;}
			?>
			<div class="tab-pane box-products  tabcarousel<?php echo $id; ?> slide" id="tab-<?php echo $tab.$id;?>">

				<?php if( count($products) > $itemsperpage ) { ?>
                <div class="carousel-controls">
				<a class="carousel-control left" href="#tab-<?php echo $tab.$id;?>"   data-slide="prev">prev</a>
				<a class="carousel-control right" href="#tab-<?php echo $tab.$id;?>"  data-slide="next">next</a>
				</div>
				<?php } ?>
				<div class="carousel-inner">
				 <?php
					$pages = array_chunk( $products, $itemsperpage);
				 ?>
				  <?php foreach ($pages as  $k => $tproducts ) {   ?>
						<div class="item <?php if($k==0) {?>active<?php } ?>">
							<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
								<?php if( $i%$cols == 1 ) { ?>
                                    <div class="row products-row">
                                        <?php } ?>
                                        <div class="swap-image col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-4 col-xs-12 product-col">
                                            <?php require( $productLayout );  ?>
                                        </div>

                                        <?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
                                    </div>
								<?php } ?>
							<?php } //endforeach; ?>
						</div>
				  <?php } ?>
				</div>
			</div>
		<?php } // endforeach of tabs ?>
	</div>
</div>


<script>
$(function () {
$('#producttabs<?php echo $id;?> a:first').tab('show');
})
$('.tabcarousel<?php echo $id;?>').carousel({interval:false,auto:false,pause:'hover'});
</script>
