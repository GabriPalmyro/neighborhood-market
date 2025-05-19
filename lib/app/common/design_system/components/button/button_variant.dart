enum DSButtonType {
  primary,
  secondary,
  primaryOutline,
  secondaryOutline,
  warning,
  warningOutline,
  ghost;

  String get value {
    switch (this) {
      case DSButtonType.primary:
        return 'primary';
      case DSButtonType.secondary:
        return 'secondary';
      case DSButtonType.primaryOutline:
        return 'primary-outline';
      case DSButtonType.secondaryOutline:
        return 'secondary-outline';
      case DSButtonType.warning:
        return 'warning';
      case DSButtonType.warningOutline:
        return 'warning-outline';
      case DSButtonType.ghost:
        return 'ghost';
    }
  }
}

enum DSButtonSize {
  sm,
  md,
  lg;

  String get value {
    switch (this) {
      case DSButtonSize.sm:
        return 'small';
      case DSButtonSize.md:
        return 'medium';
      case DSButtonSize.lg:
        return 'large';
    }
  }
}
