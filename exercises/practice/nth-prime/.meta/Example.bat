@echo off
setlocal enabledelayedexpansion

set "targetNTH=%~1"
set /a "currentCount=0"

if %targetNTH% LEQ 0 (
    echo there is no zeroth prime
    exit /b 0
)

rem Case 1: First prime is 2
if %targetNTH% EQU 1 (
    echo 2
    exit /b 0
)

set /a "currentCount=1"
set "candidate=1"

:FindNextPrime
    set /a "candidate+=2"
    
    rem Check if candidate is prime
    set "isPrime=1"
    
    rem Only check up to sqrt(candidate). We iterate odd numbers.
    rem We can approximate loop limit or just check all odd numbers < candidate/2
    rem Optimally: for j=3; j*j <= candidate; j+=2
    
    set /a "j=3"
    
    :CheckDivisor
        set /a "sq=j*j"
        if %sq% GTR %candidate% goto :PrimeFound
        
        set /a "rem=candidate %% j"
        if %rem% EQU 0 (
            set "isPrime=0"
            goto :NotPrime
        )
        
        set /a "j+=2"
        goto :CheckDivisor
        
    :PrimeFound
    set /a "currentCount+=1"
    if %currentCount% EQU %targetNTH% (
        echo %candidate%
        exit /b 0
    )
    
    :NotPrime
    goto :FindNextPrime
