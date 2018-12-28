module Observer
  def initialize
    super()
    @subjects = Array.new
  end

  protected
    def add_subject(obj)
      @subjects.push(obj)
      obj.attach(self)
    end

    def update(obj)
      @subjects.delete(obj)
      obj.detach(self)
    end
end

