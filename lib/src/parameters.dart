part of '../flutter_image_filters.dart';

class ShaderColorParameter extends ColorParameter {
  final int _offset;

  ShaderColorParameter(
    super.shaderName,
    super.displayName,
    super.value,
    this._offset,
  );

  int get offset => _offset;

  @override
  FutureOr<void> update(covariant ShaderConfiguration configuration) {
    if (configuration is BunchShaderConfiguration) {
      final conf = findByParameter(configuration);
      if (conf != null) {
        update(conf);
      }
    } else {
      configuration.floats.setAll(_offset, values);
      configuration.setNeedRedraw = true;
    }
  }

  @override
  List<double> get values => [
        value.r / 255.0 * value.a,
        value.g / 255.0 * value.a,
        value.b / 255.0 * value.a,
      ];
}

class ShaderNumberParameter extends NumberParameter {
  int _offset;

  ShaderNumberParameter(
    super.shaderName,
    super.displayName,
    super.value,
    this._offset,
  );

  int get offset => _offset;

  set setOffset(int newOffset) {
    _offset = newOffset;
  }

  @override
  void update(covariant ShaderConfiguration configuration) {
    if (configuration is BunchShaderConfiguration) {
      final conf = findByParameter(configuration);
      if (conf != null) {
        update(conf);
      }
    } else {
      configuration.floats[_offset] = floatValue;
      configuration.setNeedRedraw = true;
    }
  }
}

class ShaderRangeNumberParameter extends RangeNumberParameter {
  final int _offset;

  ShaderRangeNumberParameter(
    super.shaderName,
    super.displayName,
    super.value,
    this._offset, {
    super.min,
    super.max,
  });

  int get offset => _offset;

  @override
  void update(covariant ShaderConfiguration configuration) {
    if (configuration is BunchShaderConfiguration) {
      final conf = findByParameter(configuration);
      if (conf != null) {
        update(conf);
      }
    } else {
      configuration.floats[_offset] = floatValue;
      configuration.setNeedRedraw = true;
    }
  }
}

class ShaderPointParameter extends PointParameter {
  final int _offset;

  ShaderPointParameter(
    super.name,
    super.displayName,
    super.value,
    this._offset,
  );

  int get offset => _offset;

  @override
  void update(covariant ShaderConfiguration configuration) {
    if (configuration is BunchShaderConfiguration) {
      final conf = findByParameter(configuration);
      if (conf != null) {
        update(conf);
      }
    } else {
      configuration.floats.setAll(_offset, values);
      configuration.setNeedRedraw = true;
    }
  }
}

class ShaderMatrix4Parameter extends Mat4Parameter {
  final int _offset;

  ShaderMatrix4Parameter(
    super.name,
    super.displayName,
    super.value,
    this._offset,
  );

  int get offset => _offset;

  @override
  void update(covariant ShaderConfiguration configuration) {
    if (configuration is BunchShaderConfiguration) {
      final conf = findByParameter(configuration);
      if (conf != null) {
        update(conf);
      }
    } else {
      configuration.floats.setAll(_offset, values);
      configuration.setNeedRedraw = true;
    }
  }
}

class _AspectRatioParameter extends AspectRatioParameter {
  final int _offset;

  _AspectRatioParameter(
    super.name,
    super.displayName,
    super.value,
    this._offset,
  );

  int get offset => _offset;

  @override
  void update(covariant ShaderConfiguration configuration) {
    if (configuration is BunchShaderConfiguration) {
      final conf = findByParameter(configuration);
      if (conf != null) {
        update(conf);
      }
    } else {
      configuration.floats[_offset] = floatValue;
      configuration.setNeedRedraw = true;
    }
  }
}

class ShaderIntParameter extends ShaderNumberParameter {
  ShaderIntParameter(
    super.shaderName,
    super.displayName,
    super.value,
    super.offset,
  );

  @override
  void update(covariant ShaderConfiguration configuration) {
    if (configuration is BunchShaderConfiguration) {
      final conf = findByParameter(configuration);
      if (conf != null) {
        update(conf);
      }
    } else {
      configuration.floats[_offset] = intValue.toDouble();
      configuration.setNeedRedraw = true;
    }
  }
}

class ShaderTextureParameter extends DataParameter {
  TextureSource? textureSource;

  ShaderTextureParameter(super.name, super.displayName);

  @override
  FutureOr<void> update(covariant ShaderConfiguration configuration) async {
    if (configuration is BunchShaderConfiguration) {
      final conf = findByParameter(configuration);
      if (conf != null) {
        update(conf);
      }
    } else {
      if (asset != null) {
        textureSource = await TextureSource.fromAsset(asset!);
        configuration.setNeedRedraw = true;
      } else if (file != null) {
        textureSource = await TextureSource.fromFile(file!);
        configuration.setNeedRedraw = true;
      } else if (data != null) {
        textureSource = await TextureSource.fromMemory(data!);
        configuration.setNeedRedraw = true;
      }
    }
  }
}

extension on ConfigurationParameter {
  ShaderConfiguration? findByParameter(BunchShaderConfiguration configuration) {
    return configuration._configurations.firstWhereOrNull(
      (conf) =>
          conf.parameters.firstWhereOrNull((parameter) => parameter == this) !=
          null,
    );
  }
}
