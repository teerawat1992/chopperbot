# Chopperbot

Your daily cute assistant in Flipay

## Usage 1: Split the bill

You can get the help from chopper to calculate your bill with this syntax.
```
/split NAME AMOUNT NAME AMOUNT ... [+v | +s]
```
![image](https://user-images.githubusercontent.com/761819/70817917-315bf000-1e05-11ea-9384-f4fa718004d9.png)

The option can use to apply multiplication to all orders.   
Note that the order of options matter in the calculation.
```
+v means add vat 7%
+s means add service charge 10%
+share500 means share order 500 among all people
```

Ex. Add service charge
```
/split turbo 100 turbo 200 kendo 300 neo 400 +s
Chopper:
turbo 330
kendo 330
neo 440
total 1100
```

Ex. Add share dish
```
/split turbo 100 turbo 200 kendo 300 neo 400 +share300
Chopper:
turbo 400
kendo 400
neo 500
total 1300
```


## Deployment

For the first time, add the remote to Gigalixir.  
`GIGALIXIR_REMOTE_URL` can be found in the setup instruction.  
```
git remote add gigalixir GIGALIXIR_REMOTE_URL
```

Once you have the gigalixir remote, just push to build.
```
git push gigalixir master
```

The application will be avilable on    
https://APP_NAME.gigalixirapp.com/
