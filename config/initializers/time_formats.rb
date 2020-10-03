Time::DATE_FORMATS[:datetime_jp] = '%Y/%m/%d %H:%M'

Time::DATE_FORMATS[:time_jp] = '%H:%M'

# 使い方
# <%= xxx.created_at.to_s(:datetime_jp) %>