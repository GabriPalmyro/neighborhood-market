abstract class Exceptions implements Exception {
  const Exceptions();
}

class UnauthorizedException extends Exceptions {
  const UnauthorizedException();
}

class UnknownException extends Exceptions {
  const UnknownException();
}

class NotFoundException extends Exceptions {
  const NotFoundException();
}

class BadRequestException extends Exceptions {
  const BadRequestException(this.message);
  final String message;
}