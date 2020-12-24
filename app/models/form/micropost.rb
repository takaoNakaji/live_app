class Form::Micropost < Micropost
  REGISTRABLE_ATTRIBUTES = %i(
    live_on(1i) live_on(2i) live_on(3i)
    live_from_at(1i) live_from_at(2i) live_from_at(3i) live_from_at(4i) live_from_at(5i)
    live_to_at(1i) live_to_at(2i) live_to_at(3i) live_to_at(4i) live_to_at(5i)
    )
end