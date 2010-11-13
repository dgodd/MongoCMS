class PageDrop < Liquid::Drop
  def page=(p) ; @page = p ; end

  def to_s ; @page.to_s ; end
  def title ; @page.title ; end
  def body ; @page.body_html ; end
end
