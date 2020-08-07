SELECT COUNT(*) FROM users ;
	SELECT COUNT(*) FROM transfers WHERE send_amount_currency='CFA';
	SELECT DISTINCT COUNT(u_id) FROM transfers WHERE send_amount_currency='CFA';
	SELECT DATE_TRUNC('month',when_created) AS month,
COUNT(atx_id)  As transactions
FROM agent_transactions
WHERE when_created BETWEEN '2018-01-01' AND '2018-12-31 23:59:59'
GROUP BY 1;
	SELECT COUNT (agent_id) AS net_depositors  	   
  FROM agent_transactions
 WHERE (amount>0 ) AND when_created >= NOW() - interval '1 week' ;
SELECT COUNT (agent_id) AS net_withrawals     
   FROM agent_transactions
 WHERE (amount<0 ) AND when_created >= NOW() - interval '1 week';
	SELECT SUM (amount) As volume, city FROM agent_transactions ,agents WHERE agents.agent_id = agent_transactions.agent_id
 AND agent_transactions.when_created >= NOW() - interval '1 week' 
 GROUP BY city;
	SELECT SUM (amount) As volume, city,country FROM agent_transactions ,agents WHERE agents.agent_id = agent_transactions.agent_id
 AND agent_transactions.when_created >= NOW() - interval '1 week' 
 GROUP BY city, country;
 	SELECT SUM (send_amount_scalar) As volume,kind,ledger_location FROM transfers ,wallets WHERE wallets.wallet_id = transfers.source_wallet_id
 AND transfers.when_created >= NOW() - interval '1 week' 
 GROUP BY kind,ledger_location;
	SELECT DISTINCT(u_id) AS unique_id,COUNT(transfer_id)AS transaction_count ,SUM (send_amount_scalar) As volume,kind,ledger_location FROM transfers ,wallets WHERE wallets.wallet_id = transfers.source_wallet_id
 AND transfers.when_created >= NOW() - interval '1 week' 
GROUP BY unique_id,kind,ledger_location,transfer_id;
SELECT DISTINCT(wallet_id) AS wallet,  SUM(send_amount_scalar) AS volume
FROM transfers ,wallets WHERE wallets.wallet_id = transfers.source_wallet_id
 AND transfers.when_created >= NOW() - interval '1 month' AND (SELECT SUM (send_amount_scalar) FROM transfers)  > 10000000 
 GROUP BY wallet;

