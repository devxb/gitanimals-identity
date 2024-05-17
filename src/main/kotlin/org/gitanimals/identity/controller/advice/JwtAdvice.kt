package org.gitanimals.identity.controller.advice

import io.jsonwebtoken.JwtException
import io.jsonwebtoken.MalformedJwtException
import io.jsonwebtoken.security.SignatureException
import org.springframework.http.HttpStatus
import org.springframework.web.bind.annotation.ExceptionHandler
import org.springframework.web.bind.annotation.ResponseStatus
import org.springframework.web.bind.annotation.RestControllerAdvice

@RestControllerAdvice
class JwtAdvice {

    @ExceptionHandler(SignatureException::class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    fun handleSignatureException(signatureException: SignatureException): ErrorResponse =
        ErrorResponse.from(signatureException)

    @ExceptionHandler(MalformedJwtException::class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    fun handleMalformedJwtException(malformedJwtException: MalformedJwtException): ErrorResponse =
        ErrorResponse.from(malformedJwtException)

    @ExceptionHandler(JwtException::class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    fun handleJwtException(jwtException: JwtException): ErrorResponse = ErrorResponse("Invalid jwt")
}
