import 'package:flutter/material.dart';

import 'package:kubenav/pages/resources_details/widgets/pod_details_item_widget.dart';

import 'package:kubenav/pages/resources_list/widgets/configmap_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/cronjob_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/daemonset_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/deployment_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/endpoints_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/events_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/horizontalpodautoscaler_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/ingress_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/job_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/namespace_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/networkpolicy_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/node_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/persistentvolume_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/persistentvolumeclaim_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/pod_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/poddisruptionbudget_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/podsecuritypolicy_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/replicaset_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/secret_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/service_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/serviceaccount_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/statefulset_list_item_widget.dart';
import 'package:kubenav/pages/resources_list/widgets/storageclass_list_item_widget.dart';

// ResourceType is a enum, which can be used to categorize all the Kubernetes resources within a cluster. Besides the
// categorization of resources, no functions of kubenav should depend on it. This means in the current state of kubenav
// we are only using it in the resources page to create multiple lists of resources by the the 'ResourceType'.
enum ResourceType {
  workload,
  discoveryandloadbalancing,
  configandstorage,
  rbac,
  cluster,
}

// ResourceScope is a enum for the scope of the Kubernetes resource. A Kubernetes resource can be 'namespaced' (e.g.
// Pods, Deployments, etc.) or 'cluster' (e.g. Custom Resource Definitions, Nodes, etc.).
// To get the string representation of the scope the '.name' property can be used (e.g. 'resource.scope.name').
enum ResourceScope {
  namespaced,
  cluster,
}

// resourceScopeFromString is a helper function to get the 'ResourceScope' from it's string representation. If the
// provided scope string is 'namespaced' it will be 'ResourceScope.namespaced', if it is 'cluster' it will be
// 'ResourceScope.cluster'. If the provided scope string doesn't match one of these values we return 'null'.
ResourceScope? resourceScopeFromString(String? scope) {
  if (scope == null) {
    return null;
  }

  if (scope.toLowerCase() == 'namespaced') {
    return ResourceScope.namespaced;
  }

  if (scope.toLowerCase() == 'cluster') {
    return ResourceScope.cluster;
  }

  return null;
}

// Resource represents a single Kubernetes resource. Each resource must contain a 'ResourceType', a human readable
// title, a description and the 'resource', 'path' and 'scope' so the corresponding Kubernetes manifests can be
// retrieved from the Kubernetes API. A resource can also contain a 'buildListItem' and 'buildDetailsItem' function, to
// customize the look of the items in the resources list and details page.
//
// NOTE: If a resource is passed through different pages via query parameters, like it is done in the resource page ->
// resource list page -> resource details page flow, we shouldn't always pass the 'resource', 'path' and 'scope'
// property, so that we can also work with resources which are not defined in the 'Resources' map.
class Resource {
  ResourceType resourceType;
  String title;
  String description;
  String resource;
  String path;
  ResourceScope scope;
  bool isCRD;
  Widget Function(dynamic item)? buildListItem;
  Widget Function(dynamic item) buildDetailsItem;

  Resource({
    required this.resourceType,
    required this.title,
    required this.description,
    required this.resource,
    required this.path,
    required this.scope,
    required this.isCRD,
    this.buildListItem,
    required this.buildDetailsItem,
  });
}

// Resources contains a 'map' of all first party Kubernetes resources, like Pods, Deployments, Nodes, etc. The map
// should be used carefully. As mentioned in the 'Resource' note the app also have to work with unknown resources like
// Custom Resources.
abstract class Resources {
  static Map<String, Resource> map = {
    'cronjobs': Resource(
      resourceType: ResourceType.workload,
      title: 'CronJobs',
      description: 'A CronJob creates Jobs on a repeating schedule.',
      resource: 'cronjobs',
      path: '/apis/batch/v1beta1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => CronJobListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'daemonsets': Resource(
      resourceType: ResourceType.workload,
      title: 'DaemonSets',
      description:
          'A DaemonSet ensures that all (or some) Nodes run a copy of a Pod.',
      resource: 'daemonsets',
      path: '/apis/apps/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => DaemonSetListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'deployments': Resource(
      resourceType: ResourceType.workload,
      title: 'Deployments',
      description:
          'A Deployment provides declarative updates for Pods and ReplicaSets.',
      resource: 'deployments',
      path: '/apis/apps/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => DeploymentListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'jobs': Resource(
      resourceType: ResourceType.workload,
      title: 'Jobs',
      description:
          'A Job creates one or more Pods and will continue to retry execution of the Pods until a specified number of them successfully terminate.',
      resource: 'jobs',
      path: '/apis/batch/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => JobListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'pods': Resource(
      resourceType: ResourceType.workload,
      title: 'Pods',
      description:
          'Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.',
      resource: 'pods',
      path: '/api/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => PodListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => PodDetailsItemWidget(item: item),
    ),
    'replicasets': Resource(
      resourceType: ResourceType.workload,
      title: 'ReplicaSets',
      description:
          'A ReplicaSet\'s purpose is to maintain a stable set of replica Pods running at any given time.',
      resource: 'replicasets',
      path: '/apis/apps/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => ReplicaSetListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'statefulsets': Resource(
      resourceType: ResourceType.workload,
      title: 'StatefulSets',
      description:
          'StatefulSet is the workload API object used to manage stateful applications.',
      resource: 'statefulsets',
      path: '/apis/apps/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => StatefulSetListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'endpoints': Resource(
      resourceType: ResourceType.discoveryandloadbalancing,
      title: 'Endpoints',
      description:
          'An Endpoint is an resource that gets IP addresses of one or more pods dynamically assigned to it, along with a port.',
      resource: 'endpoints',
      path: '/api/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => EndpoinstListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'horizontalpodautoscalers': Resource(
      resourceType: ResourceType.discoveryandloadbalancing,
      title: 'HorizontalPodAutoscalers',
      description:
          'A HorizontalPodAutoscaler automatically updates a workload resource, with the aim of automatically scaling the workload to match demand.',
      resource: 'horizontalpodautoscalers',
      path: '/apis/autoscaling/v2beta1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) =>
          HorizontalPodAutoscalerListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'ingresses': Resource(
      resourceType: ResourceType.discoveryandloadbalancing,
      title: 'Ingresses',
      description:
          'An API object that manages external access to the services in a cluster, typically HTTP.',
      resource: 'ingresses',
      path: '/apis/extensions/v1beta1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => IngressListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'networkpolicies': Resource(
      resourceType: ResourceType.discoveryandloadbalancing,
      title: 'NetworkPolicies',
      description:
          'NetworkPolicies are an application-centric construct which allow you to specify how a pod is allowed to communicate with various network "entities" over the network.',
      resource: 'networkpolicies',
      path: '/apis/networking.k8s.io/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => NetworkPolicyListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'services': Resource(
      resourceType: ResourceType.discoveryandloadbalancing,
      title: 'Services',
      description:
          'An abstract way to expose an application running on a set of Pods as a network service.',
      resource: 'services',
      path: '/api/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => ServiceListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'configmaps': Resource(
      resourceType: ResourceType.configandstorage,
      title: 'ConfigMaps',
      description:
          'A ConfigMap is an API object used to store non-confidential data in key-value pairs.',
      resource: 'configmaps',
      path: '/api/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => ConfigMapListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'persistentvolumeclaims': Resource(
      resourceType: ResourceType.configandstorage,
      title: 'PersistentVolumeClaims',
      description:
          'A PersistentVolumeClaim (PVC) is a request for storage by a user.',
      resource: 'persistentvolumeclaims',
      path: '/api/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) =>
          PersistentVolumeClaimListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'persistentvolumes': Resource(
      resourceType: ResourceType.configandstorage,
      title: 'Persistent Volumes',
      description:
          'A PersistentVolume (PV) is a piece of storage in the cluster that has been provisioned by an administrator or dynamically provisioned using Storage Classes.',
      resource: 'persistentvolumes',
      path: '/api/v1',
      scope: ResourceScope.cluster,
      isCRD: false,
      buildListItem: (dynamic item) =>
          PersistentVolumeListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'poddisruptionbudgets': Resource(
      resourceType: ResourceType.configandstorage,
      title: 'PodDisruptionBudgets',
      description:
          'PDBs provide a way to limit the number of concurrent disruptions that your application experiences.',
      resource: 'poddisruptionbudgets',
      path: '/apis/policy/v1beta1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) =>
          PodDisruptionBudgetListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'secrets': Resource(
      resourceType: ResourceType.configandstorage,
      title: 'Secrets',
      description:
          'A Secret is an object that contains a small amount of sensitive data such as a password, a token, or a key.',
      resource: 'secrets',
      path: '/api/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => SecretListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'serviceaccounts': Resource(
      resourceType: ResourceType.configandstorage,
      title: 'ServiceAccounts',
      description:
          'A ServiceAccount provides an identity for processes that run in a Pod.',
      resource: 'serviceaccounts',
      path: '/api/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => ServiceAccountListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'storageclasses': Resource(
      resourceType: ResourceType.configandstorage,
      title: 'StorageClasses',
      description:
          'A StorageClass provides a way for administrators to describe the "classes" of storage they offer.',
      resource: 'storageclasses',
      path: '/apis/storage.k8s.io/v1',
      scope: ResourceScope.cluster,
      isCRD: false,
      buildListItem: (dynamic item) => StorageClassListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'clusterrolebindings': Resource(
      resourceType: ResourceType.rbac,
      title: 'Cluster Role Bindings',
      description:
          'A role binding grants the permissions defined in a role to a user or set of users.',
      resource: 'clusterrolebindings',
      path: '/apis/rbac.authorization.k8s.io/v1',
      scope: ResourceScope.cluster,
      isCRD: false,
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'clusterroles': Resource(
      resourceType: ResourceType.rbac,
      title: 'Cluster Roles',
      description:
          'An RBAC ClusterRole contains rules that represent a set of permissions.',
      resource: 'clusterroles',
      path: '/apis/rbac.authorization.k8s.io/v1',
      scope: ResourceScope.cluster,
      isCRD: false,
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'rolebindings': Resource(
      resourceType: ResourceType.rbac,
      title: 'Role Bindings',
      description:
          'A role binding grants the permissions defined in a role to a user or set of users.',
      resource: 'rolebindings',
      path: '/apis/rbac.authorization.k8s.io/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'roles': Resource(
      resourceType: ResourceType.rbac,
      title: 'Roles',
      description:
          'An RBAC Role contains rules that represent a set of permissions.',
      resource: 'roles',
      path: '/apis/rbac.authorization.k8s.io/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'events': Resource(
      resourceType: ResourceType.cluster,
      title: 'Events',
      description:
          'Events are automatically created when other resources have state changes, errors, or other messages that should be broadcast to the system.',
      resource: 'events',
      path: '/api/v1',
      scope: ResourceScope.namespaced,
      isCRD: false,
      buildListItem: (dynamic item) => EventListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'customresourcedefinitions': Resource(
      resourceType: ResourceType.cluster,
      title: 'CustomResourceDefinitions',
      description: 'Custom resources are extensions of the Kubernetes API.',
      resource: 'customresourcedefinitions',
      path: '/apis/apiextensions.k8s.io/v1',
      scope: ResourceScope.cluster,
      isCRD: false,
      buildListItem: (dynamic item) => const Text('test'),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'namespaces': Resource(
      resourceType: ResourceType.cluster,
      title: 'Namespaces',
      description:
          'Namespaces provides a mechanism for isolating groups of resources within a single cluster.',
      resource: 'namespaces',
      path: '/api/v1',
      scope: ResourceScope.cluster,
      isCRD: false,
      buildListItem: (dynamic item) => NamespaceListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'nodes': Resource(
      resourceType: ResourceType.cluster,
      title: 'Nodes',
      description:
          'A node may be a virtual or physical machine, depending on the cluster.',
      resource: 'nodes',
      path: '/api/v1',
      scope: ResourceScope.cluster,
      isCRD: false,
      buildListItem: (dynamic item) => NodeListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
    'podsecuritypolicies': Resource(
      resourceType: ResourceType.cluster,
      title: 'PodSecurityPolicies',
      description:
          'PodSecurityPolicies enable fine-grained authorization of pod creation and updates.',
      resource: 'podsecuritypolicies',
      path: '/apis/policy/v1beta1',
      scope: ResourceScope.cluster,
      isCRD: false,
      buildListItem: (dynamic item) =>
          PodSecurityPolicyListItemWidget(item: item),
      buildDetailsItem: (dynamic item) => const Text('test'),
    ),
  };
}