Order.create!(
  [
    {
      id: 1,
      customer_id: 1,
      name: '稼働　一',
      email: 'test1@test.test',
      address: '日本県乙市1-2-3',
      tel: '12345678901',
      zip: '1111111',
      status: 1,
      sum: nil
    },

    {
      id: 2,
      customer_id: 1,
      name: '稼働　一', 
      email: 'test1@test.test',
      address: '日本県乙市1-2-3', 
      tel: '12345678901', 
      zip: '1111111', 
      status: 0,
      sum: nil
    },
  ]
)