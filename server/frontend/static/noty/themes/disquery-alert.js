;(function($) {

	$.noty.themes.defaultTheme = {
		name: 'defaultTheme',
		helpers: {
			borderFix: function() {
				if (this.options.dismissQueue) {
					var selector = this.options.layout.container.selector + ' ' + this.options.layout.parent.selector;
					$(selector).css({borderRadius: '5px'});
				}
			}
		},
		modal: {
			css: {
				position: 'fixed',
				width: '100%',
				height: '100%',
				backgroundColor: '#000',
				zIndex: 10000,
				opacity: 0.6,
				display: 'none',
				left: 0,
				top: 0
			}
		},
		style: function() {

			this.$bar.css({
				overflow: 'hidden',
				margin:'10px',
				boxShadow: '0 0 10px #AAA'
			});

			this.$message.css({
				fontSize: '13px',
				lineHeight: '16px',
				textAlign: 'center',
				padding: '8px 10px 9px',
				width: 'auto',
				position: 'relative'
			});

			this.$closeButton.css({
				position: 'absolute',
				top: 4, right: 4,
				width: 14, height: 14,
				display: 'none',
				cursor: 'pointer',
			});

            this.$closeButton.addClass("icon-remove");

			this.$buttons.css({
				padding: 5,
				textAlign: 'right',
				borderTop: '1px solid #ccc',
				backgroundColor: '#fff'
			});

			this.$buttons.find('button').css({
				marginLeft: 5
			});

			this.$buttons.find('button:first').css({
				marginLeft: 0
			});

			this.$bar.bind({
				mouseenter: function() { $(this).find('.noty_close').stop().fadeTo('normal',0.5); },
				mouseleave: function() { $(this).find('.noty_close').stop().fadeTo('normal',0); }
			});

			this.$bar.css({
				borderRadius: '5px',
				border: '1px solid #eee',
			});
			this.$message.css({fontSize: '13px', textAlign: 'center'});

			switch (this.options.type) {
				case 'alert': case 'notification':
					this.$bar.css({backgroundColor: '#FFF', borderColor: '#CCC', color: '#444'});
					this.$message.css({fontWeight: 'bold'}); break;
				case 'warning':
					this.$bar.css({backgroundColor: '#FFEAA8', borderColor: '#FFC237', color: '#826200'});
    				this.$message.css({fontWeight: 'bold'});
					this.$buttons.css({borderTop: '1px solid #FFC237'}); break;
				case 'error':
					this.$bar.css({backgroundColor: '#B94A48', borderColor: 'darkred', color: '#FFF'});
					this.$message.css({fontWeight: 'bold'});
					this.$buttons.css({borderTop: '1px solid darkred'}); break;
				case 'information':
					this.$bar.css({backgroundColor: '#57B7E2', borderColor: '#0B90C4', color: '#FFF'});
					this.$message.css({fontWeight: 'bold'});
					this.$buttons.css({borderTop: '1px solid #0B90C4'}); break;
				case 'success':
					this.$bar.css({backgroundColor: 'lightgreen', borderColor: '#50C24E', color: 'darkgreen'});
					this.$message.css({fontWeight: 'bold'});
					this.$buttons.css({borderTop: '1px solid #50C24E'});break;
				default:
					this.$message.css({fontWeight: 'bold'});
					this.$bar.css({backgroundColor: '#FFF', borderColor: '#CCC', color: '#444'}); break;
			}
		},
		callback: {
			onShow: function() { $.noty.themes.defaultTheme.helpers.borderFix.apply(this); },
			onClose: function() { $.noty.themes.defaultTheme.helpers.borderFix.apply(this); }
		}
	};

})(jQuery);
