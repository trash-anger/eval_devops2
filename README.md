![docker hub](https://img.shields.io/docker/pulls/trashanger/devops2.svg?style=flat-square)
![docker hub](https://img.shields.io/docker/stars/trashanger/devops2.svg?style=flat-square)

https://hub.docker.com/r/trashanger/devops2/tags/
https://github.com/trash-anger/eval_devops2

Avec l'application de bonnes pratiques pour la sécurité du pipeline de build demandé pour l'évaluation devops 2, certains éléments ne sont pas visible dans le .zip de rendu.

Bien qu'un peu plus complexe à mettre en place, l'utilisation de dind (docker in docker) est plus sécurisé que celle de dood. 

Le build est exécuté avec un job de type multibranch pipeline :
image.png
![image.png](https://raw.githubusercontent.com/trash-anger/eval_devops2/v3/img/img1.png)

L'intérêt de cette méthode est que le pipeline ne nécessite qu'un simple Jenkinsfile pour toutes les branches.
![image.png](https://raw.githubusercontent.com/trash-anger/eval_devops2/v3/img/img2.png)

Les builds sont triggués par un webhook configuré dans github :
![image.png](https://raw.githubusercontent.com/trash-anger/eval_devops2/v3/img/img3.png)

L'intérêt de cette méthode est que le build est triggué uniquement lorsqu'une modification intervient sur une branche et il ne s'opère que sur cette branche.

Voici le xml de config de ce pipeline :
```
<?xml version='1.1' encoding='UTF-8'?>
<org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject plugin="workflow-multibranch@2.16">
  <actions/>
  <description></description>
  <properties>
    <org.jenkinsci.plugins.pipeline.modeldefinition.config.FolderConfig plugin="pipeline-model-definition@1.2.7">
      <dockerLabel></dockerLabel>
      <registry plugin="docker-commons@1.13"/>
    </org.jenkinsci.plugins.pipeline.modeldefinition.config.FolderConfig>
  </properties>
  <folderViews class="jenkins.branch.MultiBranchProjectViewHolder" plugin="branch-api@2.0.20">
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
  </folderViews>
  <healthMetrics>
    <com.cloudbees.hudson.plugins.folder.health.WorstChildHealthMetric plugin="cloudbees-folder@6.4">
      <nonRecursive>false</nonRecursive>
    </com.cloudbees.hudson.plugins.folder.health.WorstChildHealthMetric>
  </healthMetrics>
  <icon class="jenkins.branch.MetadataActionFolderIcon" plugin="branch-api@2.0.20">
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
  </icon>
  <orphanedItemStrategy class="com.cloudbees.hudson.plugins.folder.computed.DefaultOrphanedItemStrategy" plugin="cloudbees-folder@6.4">
    <pruneDeadBranches>true</pruneDeadBranches>
    <daysToKeep>-1</daysToKeep>
    <numToKeep>-1</numToKeep>
  </orphanedItemStrategy>
  <triggers/>
  <disabled>false</disabled>
  <sources class="jenkins.branch.MultiBranchProject$BranchSourceList" plugin="branch-api@2.0.20">
    <data>
      <jenkins.branch.BranchSource>
        <source class="org.jenkinsci.plugins.github_branch_source.GitHubSCMSource" plugin="github-branch-source@2.3.6">
          <id>c97e35c9-f1e7-47a3-a073-2d813902af28</id>
          <credentialsId>github_cred</credentialsId>
          <repoOwner>trash-anger</repoOwner>
          <repository>eval_devops2</repository>
          <traits>
            <org.jenkinsci.plugins.github__branch__source.BranchDiscoveryTrait>
              <strategyId>1</strategyId>
            </org.jenkinsci.plugins.github__branch__source.BranchDiscoveryTrait>
            <org.jenkinsci.plugins.github__branch__source.OriginPullRequestDiscoveryTrait>
              <strategyId>1</strategyId>
            </org.jenkinsci.plugins.github__branch__source.OriginPullRequestDiscoveryTrait>
            <org.jenkinsci.plugins.github__branch__source.ForkPullRequestDiscoveryTrait>
              <strategyId>1</strategyId>
              <trust class="org.jenkinsci.plugins.github_branch_source.ForkPullRequestDiscoveryTrait$TrustPermission"/>
            </org.jenkinsci.plugins.github__branch__source.ForkPullRequestDiscoveryTrait>
          </traits>
        </source>
        <strategy class="jenkins.branch.DefaultBranchPropertyStrategy">
          <properties class="empty-list"/>
        </strategy>
      </jenkins.branch.BranchSource>
    </data>
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
  </sources>
  <factory class="org.jenkinsci.plugins.workflow.multibranch.WorkflowBranchProjectFactory">
    <owner class="org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject" reference="../.."/>
    <scriptPath>Jenkinsfile</scriptPath>
  </factory>
</org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject>
```

L'utilisation d'un multibranch pipeline nous permet aussi de profiter d'une variable non présente dans les autres type de jobs : $(BRANCH_NAME). Il nous à été particulièrement utile car il nous permet de builder nos images avec un tag et de pousser celle-ci indépendamment sur le hub.

```
docker exec -ti dind_jenkins_1 sh -c "docker images"
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
trashanger/devops2   v2                  c640de28fd35        About an hour ago   276MB
trashanger/devops2   v3                  3ea97d745e56        About an hour ago   276MB
trashanger/devops2   v1                  234d684008b6        2 hours ago         285MB
```

Les informations d'authentification sont toutes stockées dans la configuration interne à Jenkins, ce qui les rends non visible des développeurs travaillant sur le projet. 
