#!/usr/bin/python
# -*- coding: utf-8 -*-
import sqlite3
from datetime import datetime


class DBModule:

	def __init__(self, database, username, password):
		self.name = 'sqlite3'
		self.conn = sqlite3.connect(database)
		self.c = self.conn.cursor()

	def __del__(self):
		self.c.close()

	def create_table(self, string):
		self.c.execute(string)

		self.conn.commit()

	def retrieve(self, table=None, fields=None, where=None, join=None):
		if table is None or fields is None:
			return False
		else:
			self.c.execute('SELECT {0} FROM {1} WHERE {2};'.format(fields, table, where))

			count = 0
			rows = list()
			result = dict()
			for row in self.c:
				count += 1
				rows.append(row)

			result['rows'] = rows
			result['count'] = count

			return result

	def create(self, table=None, fields=None):
		if table is None or fields is None:
			return False
		else:
			if 'created' not in fields.keys():
				fields['created'] = datetime.utcnow().strftime('%Y-%m-%d %H:%M:%S')

			values = list()
			for value in fields.values():
				try:
					float(value)
					values.append(value)
				except(ValueError):
					values.append('"' + value + '"')

			print('INSERT INTO {0} ({1}) VALUES ({2});'.format(table, ','.join(fields.keys()), ','.join(values)))
			self.c.execute('INSERT INTO {0} ({1}) VALUES ({2});'.format(table, ','.join(fields.keys()), ','.join(values)))
			self.conn.commit()

		return True

	def delete(self, table=None, where='1=0'):
		if table is None:
			return False
		else:
			print('DELETE FROM {0} WHERE {1};'.format(table, ','.join(where)))
			self.c.execute('DELETE FROM {0} WHERE {1};'.format(table, ','.join(where)))
			self.conn.commit()

		return True