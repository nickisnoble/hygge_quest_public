module ApplicationHelper
  def auth_link
    if current_user
      link_to("Logout", guests_sign_out_url)
    else
      link_to("Login", guests_sign_in_url)
    end
  end

  def render_flash_stream
    turbo_stream.update "flash", partial: "shared/flash"
  end

  def theme_colors_css
    highlight = Configuration.highlight_color
    # Generate lighter and darker shades for hover states and backgrounds
    # This is a simple approach - in production you might want a color manipulation library
    <<~CSS
      :root {
        --color-highlight: #{highlight};
        --color-highlight-hover: #{darken_color(highlight, 10)};
        --color-highlight-light: #{lighten_color(highlight, 40)};
      }
    CSS
  end

  private

  def darken_color(hex, percent)
    # Simple darkening by reducing each RGB component
    rgb = hex.match(/#(..)(..)(..)/).captures.map { |c| c.to_i(16) }
    rgb = rgb.map { |c| [(c * (100 - percent) / 100).round, 0].max }
    "#%02x%02x%02x" % rgb
  end

  def lighten_color(hex, percent)
    # Simple lightening by moving towards white
    rgb = hex.match(/#(..)(..)(..)/).captures.map { |c| c.to_i(16) }
    rgb = rgb.map { |c| [c + ((255 - c) * percent / 100).round, 255].min }
    "#%02x%02x%02x" % rgb
  end
end
