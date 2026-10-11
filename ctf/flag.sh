#!/bin/sh
# Places the player's flag (CTF_FLAG_MAIN, given by the launcher) in the table flags of the
# bank's PostgreSQL database, where its SQL injections reach it;
# without one (CI, a run by hand) the development flag.
dev='FLAG{dev-vuln-bank}'
flag=${CTF_FLAG_MAIN:-$dev}
export PGPASSWORD=postgres
i=0; until psql -h 127.0.0.1 -U postgres -d vulnerable_bank -c 'select 1' >/dev/null 2>&1; do i=$((i+1)); [ $i -gt 150 ] && exit 1; sleep 2; done
psql -h 127.0.0.1 -U postgres -d vulnerable_bank -v ON_ERROR_STOP=1 -v flag="$flag" -q <<'SQL'
CREATE TABLE IF NOT EXISTS flags (flag text NOT NULL);
DELETE FROM flags;
INSERT INTO flags (flag) VALUES (:'flag');
SQL
