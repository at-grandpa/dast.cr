struct Time
  property interval : Time::Span = 1.day

  def succ
    next_obj = self + @interval
    next_obj.interval = @interval
    next_obj
  end
end