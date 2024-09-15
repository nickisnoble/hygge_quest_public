class DungeonMaster::GuestsController < GuestsController
  include DungeonMaster::Cerberus

  def index
    @columns = {
      Name: :name,
      Party: "parties.name",
      Feast: :food_preference,
      Guild: "guilds.name",
      Notes: :notes
    }
    name = params[:name]&.downcase || ""
    sort = params[:sort] || "parties.name"
    @guests = Guest
      .joins(:party, :guild)
      .attending
      .order(sort => :asc)
      .where("lower(guests.name) LIKE ?", "%#{name}%")

    respond_to do |format|
      format.html
      format.turbo_stream
      format.csv {
        render_csv "#{Date.today.strftime("%Y-%m-%d")}-williams-noble-guests"
      }
    end
  end

  private

  def render_csv(filename = nil)
    filename ||= params[:action]
    filename += '.csv'

    if request.env['HTTP_USER_AGENT'] =~ /msie/i
      headers['Pragma'] = 'public'
      headers["Content-type"] = "text/plain"
      headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
      headers['Content-Disposition'] = "attachment; filename=\"#{filename}\""
      headers['Expires'] = "0"
    else
      headers["Content-Type"] ||= 'text/csv'
      headers["Content-Disposition"] = "attachment; filename=\"#{filename}\""
    end

    render :layout => false
  end
end
