<div class="blog-item">
		<?php if( $blog['thumb'] && $cat_show_image )  { ?>
		<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" alt="<?php echo $blog['title'];?>" style="text-align:left"/>
		<?php } ?>
<div class="row">
	<div class="blog-meta col-lg-3 col-md-3 col-sm-4 col-xs-12">
		<ul>
			  	<li><?php if( $blog_show_author ) { ?>
				<span class="author"><b><?php echo $objlang->get("text_write_by");?></b> <?php echo $blog['author'];?></span>
				<?php } ?>
				</li>

				<li>
				<?php if( $blog_show_category ) { ?>
				<span class="publishin">
					<b><?php echo $objlang->get("text_published_in");?></b>
					<a class="color" href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
				</span>
				<?php } ?>	
				</li>

				<li>
				<?php if( $blog_show_created ) { ?>
				<span class="created"><b><?php echo $objlang->get("text_created_date");?></b> <?php echo $blog['created'];?></span>
				<?php } ?>
				</li>

				<li>
				<?php if( $blog_show_hits ) { ?>
				<span class="hits"><b><?php echo $objlang->get("text_hits");?></b> <?php echo $blog['hits'];?></span>
				<?php } ?>		
				</li>

				<li>
				<?php if( $blog_show_comment_counter ) { ?>
				<span class="comment_count"><b><?php echo $objlang->get("text_comment_count");?></b> <?php echo $blog['comment_count'];?></span>
				<?php } ?>	
				</li>
	</ul>
	</div>
	<div class="blog-body col-lg-9 col-md-9 col-sm-8 col-xs-12">
		
<?php if( $cat_show_title ) { ?>
	<div class="blog-header clearfix">
	
	<h3 class="blog-title">	<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a></h3>
	</div>
	<?php } ?>
		<?php if( $cat_show_description ) {?>
		<div class="description">
			<?php echo $blog['description'];?>
		</div>
		<?php } ?>
		<?php if( $cat_show_readmore ) { ?>
		<div class="blog-readmore"><a href="<?php echo $blog['link'];?>" class="button btn btn-default"><?php echo $objlang->get('text_readmore');?></a></div>
		<?php } ?>
	</div>	
</div>
</div>