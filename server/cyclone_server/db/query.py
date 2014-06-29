_GET_LIST_OF_MERCHANT =\
    'SELECT * FROM Merchant;'   

_GET_COLLABORATIVE_FILTERING_BY_MERCHANT_ID =\
    'select name from product where id in (select distinct(productid) from merchantproduct where merchantid in'\
    ' (select distinct(merchantid) from merchantproduct where productid in (select productid from merchantproduct where merchantid = %s))'\
    ' and productid not in (select productid from merchantproduct where merchantid = %s)) group by id order by (sentiment * (select max(cost)'\
    ' from merchantproduct where productid = product.id)) desc;'

