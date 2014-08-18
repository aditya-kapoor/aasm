class CallbackNewDsl
  include AASM

  aasm do
    state :open, :initial => true,
      :before_enter => :before_enter_open,
      :after_enter  => :after_enter_open,
      :before_exit  => :before_exit_open,
      :exit         => :exit_open,
      :after_exit   => :after_exit_open

    state :closed,
      :before_enter => :before_enter_closed,
      :enter        => :enter_closed,
      :after_enter  => :after_enter_closed,
      :before_exit  => :before_exit_closed,
      :after_exit   => :after_exit_closed

    event :close, :before => :before, :after => :after do
      transitions :to => :closed, :from => [:open], :on_transition => :transitioning
    end

    event :open, :before => :before, :after => :after do
      transitions :to => :open, :from => :closed
    end
  end

  def log(text)
    puts text
  end

  def before_enter_open; log('before_enter_open'); end
  def before_exit_open; log('before_exit_open'); end
  def after_enter_open; log('after_enter_open'); end
  def after_exit_open; log('after_exit_open'); end

  def before_enter_closed; log('before_enter_closed'); end
  def before_exit_closed; log('before_exit_closed'); end
  def after_enter_closed; log('after_enter_closed'); end
  def after_exit_closed; log('after_exit_closed'); end

  def transitioning; log('transitioning'); end

  def before; log('before'); end
  def after; log('after'); end

  def enter_closed; log('enter_closed'); end
  def exit_open; log('exit_open'); end
end

class CallbackNewDslArgs
  include AASM

  aasm do
    state :open, :initial => true,
      :before_enter => :before_enter_open,
      :after_enter  => :after_enter_open,
      :before_exit  => :before_exit_open,
      :exit         => :exit_open,
      :after_exit   => :after_exit_open

    state :closed,
      :before_enter => :before_enter_closed,
      :enter        => :enter_closed,
      :after_enter  => :after_enter_closed,
      :before_exit  => :before_exit_closed,
      :after_exit   => :after_exit_closed

    event :close, :before => :before, :after => :after do
      transitions :to => :closed, :from => [:open], :on_transition => :transition_proc
    end

    event :open, :before => :before, :after => :after do
      transitions :to => :open, :from => :closed
    end
  end

  def before_enter_open; end
  def before_exit_open; end
  def after_enter_open; end
  def after_exit_open; end

  def before_enter_closed; end
  def before_exit_closed; end
  def after_enter_closed; end
  def after_exit_closed; end

  def before(*args); end
  def transition_proc(arg1, arg2); end
  def after(*args); end

  def enter_closed; end
  def exit_open; end

end

class CallbackWithStateArg

  include AASM

  aasm do
    state :open, :inital => true
    state :closed
    state :out_to_lunch

    event :close, :before => :before_method, :after => :after_method do
      transitions :to => :closed, :from => [:open], :on_transition => :transition_method
      transitions :to => :out_to_lunch, :from => [:open], :on_transition => :transition_method2
    end
  end

  def before_method(arg); end

  def after_method(arg); end

  def transition_method(arg); end

  def transition_method2(arg); end

end
