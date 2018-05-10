<?php 

	$span = 12/$cols; 
	$id = rand(1,9)+rand();	
?>
<div class="box box-categories-accessoires">
	<div class="box-heading hidden">
		<span><?php echo $objlang->get("heading_title");?></span>
	</div>
	<div class="box-items slide" id="box-accessoires-<?php echo $id;?>">
		<?php if( count($categories) > $itemsperpage ) { ?>
		<div class="carousel-controls">
			<a class="carousel-control left" href="#box-accessoires-<?php echo$id;?>"   data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="#box-accessoires-<?php echo $id;?>"  data-slide="next">&rsaquo;</a>
		</div>
		<?php } ?>
		<div class="carousel-inner ">
			<?php $pages = array_chunk( $categories, $itemsperpage);?>
			<?php foreach ($pages as  $k => $tcategories ) { ?>
			<div class="item <?php if($k==0) {?>active<?php } ?>">
				<?php foreach( $tcategories as $i => $category ) {  $i=$i+1;?>
				<?php if( $i%$cols == 1 ) { ?>
				<div class="row">
				<?php } ?>
					<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-<?php echo $span;?> col-xs-12">
						<div class="accessories-wrapper">
						<?php 
							$count = $category['parent']['count']; 
							if($count == 0 || $count == 1){
								$label = $count.' '.$objlang->get("text_item");
							} else {
								$label = $count.' '.$objlang->get("text_items");
							}
						?>
							
								<div class="image img-overlay">
									<?php if (!empty($category['parent']['image'])){ ?>
										<a href="<?php echo $category['parent']['href']; ?>"><img src="<?php echo $category['parent']['image']; ?>" alt=""/></a>
									<?php } ?>	
								</div>
								<div class="box-content">
									<div class="accessories-title">
										<a href="<?php echo $category['parent']['href']; ?>"><?php echo $category['parent']['name']; ?></a>
									</div>
									<div class="description"><?php echo $label; ?></div>								
								</div>
							
						</div>
					</div>
				<?php if( $i%$cols == 0 || $i==count($tcategories) ) { ?>
				</div>
				<?php } ?>
				<?php } //end foreach?>
			</div>
			<?php } //end foreach?>
			
		</div>
	</div>
	
</div>