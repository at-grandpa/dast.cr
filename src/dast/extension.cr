struct Time
  property interval : Time::MonthSpan | Time::Span = 1.day

  def range(to : Time, interval : Time::MonthSpan | Time::Span)
    self.interval = interval
    self..to
  end

  def succ
    next_obj = self + @interval
    next_obj.interval = @interval
    next_obj
  end
end
