# Ticket 101, front-end part. Overview.

The overview of back-end part can be found by the following link: https://github.com/kemplar285/intern-decision-engine-backend\

The front-end part of the task was quite good. I did a number of minor changes, the biggest of them was splitting loan form into separate widgets.

Goods: 
1. Front-end side input validation
2. API calls working.
3. Designed nicely.
4. 

Bads:
1. Loan form was composed of one giant class that is hard to maintain, which contradicts SOLID principlees. 
It was split into multiple more managable widgets.
2. Wrong loan limits and period constants used.
3. Slider sends API requests on every slider tick. Probably should be on release to avoid performance issues. Could have been done on purpose, so I didn't change this part.
4. Use of hardcoded API URLs. I changed it to env variables to allow more flexibility.
5. Deprecated methods used.
6. A full blown project duplicate was inside inbank-frontend-98f09aabec29a741365f750db29dfe606f20f0b2. Why?
7. Use of Expanded with Center element is not allowed.
8. Use of random numbers instead of constants.


