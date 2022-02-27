//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class IoK8sApiAuthorizationV1SubjectAccessReviewSpec {
  /// Returns a new [IoK8sApiAuthorizationV1SubjectAccessReviewSpec] instance.
  IoK8sApiAuthorizationV1SubjectAccessReviewSpec({
    this.extra = const {},
    this.groups = const [],
    this.nonResourceAttributes,
    this.resourceAttributes,
    this.uid,
    this.user,
  });

  /// Extra corresponds to the user.Info.GetExtra() method from the authenticator.  Since that is input to the authorizer it needs a reflection here.
  Map<String, List<String>> extra;

  /// Groups is the groups you're testing for.
  List<String> groups;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IoK8sApiAuthorizationV1NonResourceAttributes? nonResourceAttributes;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IoK8sApiAuthorizationV1ResourceAttributes? resourceAttributes;

  /// UID information about the requesting user.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? uid;

  /// User is the user you're testing for. If you specify \"User\" but not \"Groups\", then is it interpreted as \"What if User were not a member of any groups
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IoK8sApiAuthorizationV1SubjectAccessReviewSpec &&
          other.extra == extra &&
          other.groups == groups &&
          other.nonResourceAttributes == nonResourceAttributes &&
          other.resourceAttributes == resourceAttributes &&
          other.uid == uid &&
          other.user == user;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (extra.hashCode) +
      (groups.hashCode) +
      (nonResourceAttributes == null ? 0 : nonResourceAttributes!.hashCode) +
      (resourceAttributes == null ? 0 : resourceAttributes!.hashCode) +
      (uid == null ? 0 : uid!.hashCode) +
      (user == null ? 0 : user!.hashCode);

  @override
  String toString() =>
      'IoK8sApiAuthorizationV1SubjectAccessReviewSpec[extra=$extra, groups=$groups, nonResourceAttributes=$nonResourceAttributes, resourceAttributes=$resourceAttributes, uid=$uid, user=$user]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    json[r'extra'] = extra;
    json[r'groups'] = groups;
    if (nonResourceAttributes != null) {
      json[r'nonResourceAttributes'] = nonResourceAttributes;
    }
    if (resourceAttributes != null) {
      json[r'resourceAttributes'] = resourceAttributes;
    }
    if (uid != null) {
      json[r'uid'] = uid;
    }
    if (user != null) {
      json[r'user'] = user;
    }
    return json;
  }

  /// Returns a new [IoK8sApiAuthorizationV1SubjectAccessReviewSpec] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static IoK8sApiAuthorizationV1SubjectAccessReviewSpec? fromJson(
      dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "IoK8sApiAuthorizationV1SubjectAccessReviewSpec[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "IoK8sApiAuthorizationV1SubjectAccessReviewSpec[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return IoK8sApiAuthorizationV1SubjectAccessReviewSpec(
        // TODO: Fix original generated code
        // extra: json[r'extra'] == null ? const {} : mapCastOfType<String, List>(json, r'extra'),
        extra: const {},
        groups: json[r'groups'] is List
            ? (json[r'groups'] as List).cast<String>()
            : const [],
        nonResourceAttributes:
            IoK8sApiAuthorizationV1NonResourceAttributes.fromJson(
                json[r'nonResourceAttributes']),
        resourceAttributes: IoK8sApiAuthorizationV1ResourceAttributes.fromJson(
            json[r'resourceAttributes']),
        uid: mapValueOfType<String>(json, r'uid'),
        user: mapValueOfType<String>(json, r'user'),
      );
    }
    return null;
  }

  static List<IoK8sApiAuthorizationV1SubjectAccessReviewSpec>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <IoK8sApiAuthorizationV1SubjectAccessReviewSpec>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value =
            IoK8sApiAuthorizationV1SubjectAccessReviewSpec.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, IoK8sApiAuthorizationV1SubjectAccessReviewSpec>
      mapFromJson(dynamic json) {
    final map = <String, IoK8sApiAuthorizationV1SubjectAccessReviewSpec>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = IoK8sApiAuthorizationV1SubjectAccessReviewSpec.fromJson(
            entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of IoK8sApiAuthorizationV1SubjectAccessReviewSpec-objects as value to a dart map
  static Map<String, List<IoK8sApiAuthorizationV1SubjectAccessReviewSpec>>
      mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map =
        <String, List<IoK8sApiAuthorizationV1SubjectAccessReviewSpec>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value =
            IoK8sApiAuthorizationV1SubjectAccessReviewSpec.listFromJson(
          entry.value,
          growable: growable,
        );
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{};
}