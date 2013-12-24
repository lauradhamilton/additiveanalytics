class ProductsDatatable
  delegate :params:@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      aaData: data
    }
  end
