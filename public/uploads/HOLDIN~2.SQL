------------------------------------------------------
----- Hloding Value & Balance For EQUITY Clients -----
------------------------------------------------------
SELECT
    dq.client_code ,
    client.client_name ||' '||client.father_husb_name client_name,
    Bc.Branch_Name,
    (sum(decode(custody_status_activity('ALL',dq.activity_code),1,0,decode(dq.in_or_out,'I',dq.quantity,-dq.quantity))) + 
sum(decode(custody_status_activity(cs.bank_delv_actv,dq.activity_code),1,decode(dq.registered,1,decode(dq.in_or_out,'I',dq.quantity,-dq.quantity),0),0) ) + 
sum(decode(custody_status_activity('CRP',dq.activity_code),1,decode(dq.in_or_out,'I',dq.quantity,-dq.quantity),0))
) Holding,
    (sum(decode(custody_status_activity('ALL',dq.activity_code),1,0,decode(dq.in_or_out,'I',dq.quantity,-dq.quantity)) * Em1.Close_Rate) + 
sum(decode(custody_status_activity(cs.bank_delv_actv,dq.activity_code),1,decode(dq.registered,1,decode(dq.in_or_out,'I',dq.quantity,-dq.quantity),0),0) * Em1.Close_Rate) + 
sum(decode(custody_status_activity('CRP',dq.activity_code),1,decode(dq.in_or_out,'I',dq.quantity,-dq.quantity),0) * Em1.Close_Rate)
) Holding_Value  ,
Sum(get_sl_balance_equity(system.gl_sl_type_client,
                             client.client_code,
                             &As_On,
                             'ALL',
                             1,
                             'C',
                             'F')) Balance
    
   FROM(
    SELECT cm.activity_code,cm.client_code,cm.isin,cm.in_or_out,sum(cm.reg_quantity) quantity,1 registered,
    '0' clearing_type,0 net_reg_unbilled,0 net_spot_unbilled,0 net_forward_unbilled
    FROM custody_master cm
    WHERE cm.transaction_Date<= &as_on
        and cm.client_code = decode(&client, '%', cm.client_code, &client)
        and cm.isin = decode(&security, '%', cm.isin, &security)
        and cm.post=1
   group by cm.activity_code,cm.client_code,cm.isin,cm.in_or_out
UNION ALL
    SELECT cm.activity_code,cm.client_code,cm.isin,cm.in_or_out,sum(cm.un_reg_quantity) quantity,0 registered,
    '0' clearing_type,0 net_reg_unbilled,0 net_spot_unbilled,0 net_forward_unbilled
    FROM custody_master cm
    WHERE cm.transaction_Date<= &as_on
        and cm.client_code = decode(&client, '%', cm.client_code, &client)
        and cm.isin = decode(&security, '%', cm.isin, &security)
        and cm.post=1
   group by cm.activity_code,cm.client_code,cm.isin,cm.in_or_out
UNION ALL
----- BACK DATE BILLED 
                  select scm.activity_code,scm.client_code,
                         scm.isin,scm.in_or_out,
                         sum(scm.quantity),1 registered,
                         '0' clearing_type,0 net_reg_unbilled,
                         0 net_spot_unbilled,0 net_forward_unbilled
                    from (SELECT cm.clearing_no,cm.activity_code,cm.client_code,cm.isin,
                                 cm.in_or_out,sum(cm.reg_quantity) quantity
                            FROM custody_master cm
                           WHERE cm.CLIENT_CODE =  DECODE(&client, '%', cm.client_code, &client) and
                                 cm.isin = decode(&security, '%', cm.isin, &security) AND
                                 cm.transaction_Date > &as_on and
                                 cm.clearing_no is not null
                           group by cm.clearing_no,
                                    cm.activity_code,
                                    cm.client_code,
                                    cm.isin,
                                    cm.in_or_out
                          having(sum(cm.reg_quantity) <> 0)) scm,
                         clearing_calendar cc
                   where scm.clearing_no = cc.clearing_no and
                         cc.clearing_end_date <= &as_on
                   group by scm.activity_code,
                            scm.client_code,
                            scm.isin,
                            scm.in_or_out
                  having(sum(scm.quantity) <> 0)
UNION ALL
                      select scm.activity_code,
                             scm.client_code,
                             scm.isin,
                             scm.in_or_out,
                             sum(scm.quantity),
                             0 registered,
                             '0' clearing_type,
                             0 net_reg_unbilled,
                             0 net_spot_unbilled,
                             0 net_forward_unbilled
                        from (SELECT cm.clearing_no,
                                     cm.activity_code,
                                     cm.client_code,
                                     cm.isin,
                                     cm.in_or_out,
                                     sum(cm.un_reg_quantity) quantity
                                FROM custody_master cm
                               WHERE cm.CLIENT_CODE =
                                     DECODE(&client,
                                            '%',
                                            cm.client_code,
                                            &client) and
                                     cm.isin =
                                     decode(&security, '%', cm.isin, &security) AND
                                     cm.transaction_Date > &as_on and
                                     cm.clearing_no is not null
                               group by cm.clearing_no,
                                        cm.activity_code,
                                        cm.client_code,
                                        cm.isin,
                                        cm.in_or_out
                              having(sum(cm.un_reg_quantity) <> 0)) scm,
                             clearing_calendar cc
                       where scm.clearing_no = cc.clearing_no and
                             cc.clearing_end_date <= &as_on
                       group by scm.activity_code,
                                scm.client_code,
                                scm.isin,
                                scm.in_or_out
                      having(sum(scm.quantity) <> 0)
----- OPENING BALANCE      
UNION ALL
    SELECT cob.activity_code,cob.client_code,cob.isin,
    decode(custody_status_activity('ALL',cob.activity_code),1,'O','I') in_or_out,
    reg_quantity quantity,1 registered,
    '0' clearing_type,0 net_reg_unbilled,0 net_spot_unbilled,0 net_forward_unbilled
    FROM custody_opening_balances cob
    Where cob.client_code = decode(&client, '%', cob.client_code, &client)
       and cob.isin = decode(&security, '%', cob.isin, &security)
       and cob.post=1
UNION ALL
    SELECT  cob.activity_code,cob.client_code,cob.isin,
    decode(custody_status_activity('ALL',cob.activity_code),1,'O','I') in_or_out,
    un_reg_quantity quantity,0 registered,
    '0' clearing_type,0 net_reg_unbilled,0 net_spot_unbilled,0 net_forward_unbilled
    FROM custody_opening_balances cob
    Where cob.client_code = decode(&client, '%', cob.client_code, &client)
        and cob.isin = decode(&security, '%', cob.isin, &security)
        and cob.post=1        
UNION ALL
select decode(s.cds_security,1,decode(eq.buy_or_sell,'B',ct.cdc_in_activity_code,ct.cdc_out_activity_code),decode(eq.buy_or_sell,'B',ct.phy_in_activity_code,ct.phy_out_activity_code)) activity_code, eq.client_code,eq.isin,null,0 quantity,0 registered,
cal.clearing_type,
    decode(ct.trade_days||ct.settlement_days,ct_reg.trade_days||ct_reg.settlement_days,decode(eq.buy_or_sell,'B',eq.volume,-eq.volume),0) net_reg_unbilled,
    decode(ct.trade_days||ct.settlement_days,1||1,decode(eq.buy_or_sell,'B',eq.volume,-eq.volume),1||0,decode(eq.buy_or_sell,'B',eq.volume,-eq.volume),0) net_spot_unbilled,
    decode(cal.clearing_type,s.forward_clearing_type,decode(eq.buy_or_sell,'B',eq.volume,-eq.volume),0) net_forward_unbilled
from equity_trade eq,clearing_calendar cal,security s,clearing_type ct,equity_system es,clearing_type ct_reg
where
eq.clearing_no = cal.clearing_no
and cal.clearing_type = ct.clearing_type
and ct_reg.clearing_type = es.reg_clr_type
and eq.isin = s.isin
and eq.bill_number is null
and eq.trade_date <= &as_on
and eq.client_code=decode(&client, '%', eq.client_code, &client)
and eq.isin = decode(&security, '%', eq.isin, &security)
and eq.post=1
) dq,custody_activity_group cag,custody_activity ca,custody_system cs,security,client, system,locations, CLIENT_INFO CI,executive_clients,
Branch Bc, 
(select em.isin,em.close_rate,em.price_date
  from equity_market em, (select isin,max(price_date) P_date
                          from equity_market 
                          where price_date <= &As_On
                          group by isin) temp
       where em.isin = temp.isin
       and em.price_date = temp.p_date) EM1   
WHERE ca.activity_group=cag.activity_group
    and dq.activity_code = ca.activity_code
    and dq.isin = security.isin
    and Client.Branch_Code = Bc.Branch_Code
    And Security.Isin = Em1.Isin(+)
    and dq.client_code = client.client_code    
    and dq.CLIENT_CODE = CI.CLIENT_CODE(+)  
    and dq.client_code = executive_clients.client_code(+)    
    and system.location_code = locations.location_code
    and ca.post = 1
    and cag.post =1
--------------------------------------------------
    /*and exists (select 1
          from branch_client bc, business_area b
         where bc.client_code = client.client_code
           and bc.area_code = b.area_code
           and b.equity_applicable = 1)*/
--------------------------------------------------
    
    GROUP BY dq.client_code,
    client.client_name,
    client.father_husb_name,
    Bc.Branch_Name
Order By dq.client_code  ;
