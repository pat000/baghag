<?php 
	 
	$id='newsletter'.rand();
?>
<?php if( $mode == 'flybot') { ?>
<div class="footer-newsletter hidden-xs hide" id="<?php echo $id; ?>">
  <div class="button-group">
      <div class="close">
          <i class="fa fa-angle-left"></i>
          <div data-position="show" class="show-button" id="newsletter-action">
            <label class="checkbox-inline">
          <input type="radio" checked="checked" value="show" name="action"><?php echo $objlang->get('always_show'); ?></label>
              <label class="checkbox-inline">
          <input type="radio" value="hide" name="action"><?php echo $objlang->get('keep_footer') ?></label>
          </div>
      </div>
  </div>
  <div class="container">
    <div class="row">
    	<div class="col-sm-10 col-lg-offset-2 col-md-offset-2 ">
    		<div class="newsletter-fly">
		    	<div class="image pull-left">
					<?php if (!empty($social)): ?>
							<?php  echo html_entity_decode( $social );?>
					<?php endif ?>
				</div>

		      	<div class="box form-newsletter pull-right">
					<div class="box-left pull-left">
						<div class="box-heading"><?php echo $objlang->get("entry_newsletter");?></div>
						<div><?php echo html_entity_decode( $description );?></div>
					</div>
					<div class="block_content">		
							<form id="formNewLestter" method="post" action="<?php echo $action; ?>">
								<div class="input-group">

								<input type="text" class="inputNew" <?php if(!isset($customer_email)): ?> onblur="javascript:if(this.value=='')this.value='<?php echo $objlang->get("default_input_text");?>';" onfocus="javascript:if(this.value=='<?php echo $objlang->get("default_input_text");?>')this.value='';"<?php endif; ?> value="<?php echo isset($customer_email)?$customer_email:$objlang->get("default_input_text");?>" size="18" name="email">
								<span class="input-group-btn">
									<input type="submit" name="submitNewsletter" class="button button_mini" value="<?php echo $objlang->get("button_subscribe");?>"/><span class="btn-arrow-right"></span>
									<input type="hidden" value="1" name="action"/>
								</span>
									
								</div>		
				
							<div class="valid"></div>
						</form>
					</div>
				</div>
			</div>
		</div>	<!-- end offset -->
    </div>
  </div>
</div>
<script type="text/javascript">
	$(document).ready( function(){ 
		$("#<?php echo $id;?>").appendTo( 'body' ).removeClass('hide');
	} );
	   var OC_switch_Newsletter = function( position ){
		    "use strict";
		    var $item = $('.footer-newsletter');
		    var $copy = $('#powered');
		    if(position=='show'){
		        $item.addClass('open');
		        $copy.addClass('newsletter-fix');
		        $item.removeClass('bottom');
		    }else{
		        $item.removeClass('open');
		        $copy.removeClass('newsletter-fix');
		        $item.addClass('bottom');
		    }
		}
		var OC_Newsletter = function(){
		    "use strict";
		    var $item = $('.footer-newsletter');
		    var $copy = $('#powered');
		    var $action = $('#newsletter-action');
		    if($item.length>0){
		        OC_switch_Newsletter($action.data('position'));
		        
		        $action.find('input[type="radio"]').on('change', function() {
		            var $position = $(this).val();
		            console.log($position);
		            OC_switch_Newsletter($position);
		        });
		    }
		}
		jQuery(document).ready(function() {
		    OC_Newsletter();
		});

</script>
<?php } else { ?>
<div class="<?php echo $prefix; ?> box newsletter" id="newsletter_<?php echo $position.$id;?>">
	<div class="box-title"><?php echo $objlang->get("entry_newsletter");?></div>
	
	<div class="content">
		<div class="description"><?php echo html_entity_decode( $description );?></div>
		<div class="social hidden"><?php echo html_entity_decode( $social );?></div>
			<form id="formNewLestter" method="post" action="<?php echo $action; ?>">
			<p>
				<input type="text" class="inputNew" <?php if(!isset($customer_email)): ?> onblur="javascript:if(this.value=='')this.value='<?php echo $objlang->get("default_input_text");?>';" onfocus="javascript:if(this.value=='<?php echo $objlang->get("default_input_text");?>')this.value='';"<?php endif; ?> value="<?php echo isset($customer_email)?$customer_email:$objlang->get("default_input_text");?>" size="18" name="email">

				<br/>
					<input type="submit" name="submitNewsletter" class="button button_mini" value="<?php echo $objlang->get("button_subscribe");?>"/><span class="btn-arrow-right"></span>	
					<input type="hidden" value="1" name="action"/>
			</p>
			<div class="valid"></div>
		</form>
	</div>
</div>
<?php } ?>
<script type="text/javascript"><!--

	$( document ).ready(function() {
		var id = 'newsletter_<?php echo $position.$id;?>';
		$('#'+id+' .box-heading').bind('click', function(){
			$('#'+id).toggleClass('active');
		});

		$('#formNewLestter').on('submit', function() {
			var email = $('.inputNew').val();
			$(".success_inline, .warning_inline, .error").remove();
			if(!isValidEmailAddress(email)) {				
			$('.valid').html("<div class=\"error alert alert-danger\"><?php echo $objlang->get('valid_email'); ?><button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button></div></div>");
			$('.inputNew').focus();
			return false;
		}
		var url = "<?php echo $action; ?>";
		$.ajax({
			type: "post",
			url: url,
			data: $("#formNewLestter").serialize(),
			dataType: 'json',
			success: function(json)
			{
				$(".success_inline, .warning_inline, .error").remove();
				if (json['error']) {
					$('.valid').html("<div class=\"warning_inline alert alert-danger\">"+json['error']+"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button></div>");
				}
				if (json['success']) {
					$('.valid').html("<div class=\"success_inline alert alert-success\">"+json['success']+"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button></div>");
				}
			}
		});
		return false;
	});
});

function isValidEmailAddress(emailAddress) {
	var pattern = new RegExp(/^(("[\w-\s]+")|([\w-]+(?:\.[\w-]+)*)|("[\w-\s]+")([\w-]+(?:\.[\w-]+)*))(@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$)|(@\[?((25[0-5]\.|2[0-4][0-9]\.|1[0-9]{2}\.|[0-9]{1,2}\.))((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\.){2}(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[0-9]{1,2})\]?$)/i);
	return pattern.test(emailAddress);
}
--></script>