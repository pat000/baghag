<?php  echo $header; ?> <?php require( PAVO_THEME_DIR."/template/common/config_layout.tpl" );  ?>
<?php
	$themeConfig = (array)$sconfig->get('themecontrol');
	$fullclass = isset($themeConfig['home_container_full'])&&$themeConfig['home_container_full']?"-full":""; 
?>

<div class="container<?php echo $fullclass; ?>">
  <div class="row"><?php if( $SPAN[0] ): ?>
			<div id="sidebar-left" class="col-md-<?php echo $SPAN[0];?>">
				<?php echo $column_left; ?>
			</div>	
		<?php endif; ?> 
  
   <section id="sidebar-main" class="col-md-<?php echo $SPAN[1];?>">
   	<div id="content">
   	<?php echo $content_top; ?><?php echo $content_bottom; ?>
   	</div>
   </section> 
<?php if( $SPAN[2] ): ?>
	<div id="sidebar-right" class="col-md-<?php echo $SPAN[2];?>">	
		<?php echo $column_right; ?>
	</div>
<?php endif; ?></div>
</div>
<?php echo $footer; ?>