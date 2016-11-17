def pas_tri(line)
  return [1] if line == 1
  answer = [1]
  previous = pas_tri(line - 1)
  previous.each_with_index do |el, idx|
    if previous[idx+1].nil?
      answer << el
    else
      answer << el + previous[idx+1]
    end
  end
  return answer
end

p pas_tri(1) == [1]
p pas_tri(7) == [1,6,15,20,15,6,1]
