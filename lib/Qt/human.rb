class QtHuman < Qt::Object
  signals :unlock

  def request_move(runner)
    emit unlock
  end
end
